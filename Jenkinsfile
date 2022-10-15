pipeline {
	agent { label 'xcode13' }

	parameters {
		string(name: 'CONFIGURATION', defaultValue: 'Release', description: 'Debug|Release')
		string(name: 'ENV', defaultValue: '', description: 'uat|production')
		booleanParam(name: 'RASP', defaultValue: true, description: '')
		booleanParam(name: 'UPLOAD_ARCHIVE', defaultValue: false, description: '')
		booleanParam(name: 'SKIP_TEST', defaultValue: false, description: '')
		booleanParam(name: 'SKIP_UI_TEST', defaultValue: true, description: '')
		booleanParam(name: 'SKIP_SCAN', defaultValue: true, description: '')
		string(name: 'RELEASE_NOTE', defaultValue: '', description: '')
	}

	environment {
		xcode = '13.0'
	}

	options {
		timestamps()
		buildDiscarder(logRotator(numToKeepStr: '10'))
		disableConcurrentBuilds()
	}

	stages {
		stage('Initialization') {
			steps {
				script {
					if ((params.CONFIGURATION ==~ /^(Debug|Release)$/) == false) {
						error "Invalid CONFIGURATION"
					}

					env.dryRun = false
					env.ENV = params.ENV

					// Not neccessary, ensure self-signed production build to each PR
					if (env.ENV_PRIMARY == "") {
						def props = readJSON file: './BuildScripts/deploy.json'
						if (env.BRANCH_NAME != null && props[env.BRANCH_NAME] != null) {
							if (props["${env.BRANCH_NAME}"]['env_primary'] != null) {
								env.ENV_PRIMARY = props["${env.BRANCH_NAME}"]['env_primary']
							} else {
								env.ENV_PRIMARY = "production"
								env.dryRun = true
							}
						} else {
							env.ENV_PRIMARY = "production"
						}
					}

					if (("${env.ENV_PRIMARY}" ==~ /^(uat|production)$/) == false) {
						error "Wrong ENV_PRIMARY"
					}

					// You could combine string by different flag checking, to get the config name needed
					def raspFlag = "Rasp"
					if (!params.RASP) {
						raspFlag = "Norasp"
					}
					env.flavour = "${env.ENV_PRIMARY}"
					env.xcconfig = "${env.flavour}${raspFlag}"
				}
			}
		}

		stage('Checkout') {
			// Ensure each time of ci run no cache data from previous
			steps {
				sh 'killall "Simulator" || echo "Simulator is stop running"'
				echo 'Checking out...'
				checkout scm
			}
		}

		stage('Prepare') {
			// Provide neccessary data / permission to enter corresponding flow
			environment {
				GITHUB = credentials('github-login')
				NEXUS = credentials('nexus-login')
			}

			steps {
				sh """
					./BuildScripts/retrieve-dependencies.sh ${xcode} ${env.ENV_PRIMARY}
				"""
			}
		}

		stage('Import signing') {
			// Suggest signing info with config like `./BuildScripts/import-signing-config.json`, increase flexibility for config
			// Sensitive info must not put in here
			environment {
				MY_KEYCHAIN = credentials('certificates-keychain-name')
				CERTS_PASSWORD = credentials('certificates-keychain-password')
			}

			steps {
				ansiColor('xterm') {
					sh """
						security import $CERT -k "$MY_KEYCHAIN" -P "$CERTS_PASSWORD" -T "/usr/bin/codesign"
					"""
				}
			}
		}

		stage('Test') {
			// May consider to split into 2 stages: Unit Test & UI Test
			when {
				anyOf {
					expression { params.SKIP_TEST == false }
					expression { params.SKIP_UI_TEST == false }
				}
			}

			steps {
				// If any submodule need to be built to support test, free to call additional shell here
				sh """
					./BuildScripts/build-framework.sh Debug 'platform=iOS Simulator, name=iPhone 13, OS=latest'
				"""

				// Consider calling backend handling to better manage details for the test
				// Only handle test detail info from local, e.g. scheme name & destination from `./BuildScripts/test-config.json`
				script {
					if (!params.SKIP_TEST) {
						sh """
							set -o pipefail && xcodebuild -project CICDDemo.xcodeproj -scheme CICDDemoTest -sdk iphonesimulator -destination 'platform=iOS Simulator,name=iPhone 12,OS=15.0' test
						"""
					}

					if (!params.SKIP_UI_TEST) {
						// Run UI Test
					}
				}
			}

			post {
				failure {
					archiveArtifacts artifacts: 'CICDDemoTest/TestSupport/FailureDiffs/*/**', allowEmptyArchive: true
				}
				always {
					junit(testResults: "build/reports/*.xml")
				}
			}
		}

		stage('Scan') {
			when {
				expression { params.SKIP_SCAN == false }
			}

			steps {
				ansiColor('xterm') {
					// Set credentials to Sonarqube
					// Trigger code scan from backend
				}
			}
		}

		stage ('Build') {
			steps {
				ansiColor('xterm') {
					sh """
						./BuildScripts/build-framework.sh ${params.CONFIGURATION}
					"""
					sh """
						./BuildScripts/build-for-archiving.sh ${params.CONFIGURATION} ${env.flavour} ${xcconfig}
					"""
				}
			}
		}

		stage('Archive') {
			when {
				anyOf {
					branch 'master'; branch 'develop*';
				}
			}

			steps {
				ansiColor('xterm') {
					sh """
						./BuildScripts/export-archive.sh ${params.CONFIGURATION} ${env.flavour} ${xcconfig}
					"""
				}

				script {
					if (params.RASP) {
						sh """
						./BuildScripts/rasp.sh ${env.ENV_PRIMARY} ${xcconfig}
						"""
					}
				}
			}
		}

		stage('Deploy') {
			environment {
				CYBERWORKFLOWS = credentials('cyberworkflows-service-account')
				MOBILE_CI_EPHEMERAL = credentials('mobile-ephemeral-agent-user')
				MOBILE_CI_STATIC = credentials('mobile-static-agent-user')
			}

			when {
				anyOf {
					branch 'master'; branch 'develop*';
				}
			}

			steps {
				ansiColor('xterm') {
					script {
						if (params.RASP) {
							sh """
								./build/${xcconfig}/CICDDemo.ipa --rasp-check
							"""
						}

						if (env.ENV_PRIMARY == 'production' || params.UPLOAD_ARCHIVE) {
							archiveArtifacts artifacts: 'build/**/CICDDemo.ipa, build/CICDDemo.xcarchive/dSYMs/CICDDemo.app.dSYM.zip', fingerprint: true
						}
						if (env.ENV_PRIMARY != "production" && !env.dryRun.toBoolean()) {
							def releaseNote = params.RELEASE_NOTE
							if (releaseNote == "") {
								releaseNote += "Auto build for `${BRANCH_NAME}` w/ build number `${BUILD_NUMBER}` from commit `${GIT_COMMIT}`"
								if (!params.RASP && !params.CP) {
									releaseNote += " - Security Test"
								}
							}
							// Trigger app center upload from backend
						}
					}
				}
			}
		}
	}

	post {
		// Trigger slack notification api w/ customised message to each block you need
		success {}
		failure {}
		aborted {}
		unstable {}
	}
}