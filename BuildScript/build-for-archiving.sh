#!/bin/bash
set -e

# Suppose pass default value as following comment
CONFIGURATION=$1	#Release
BUILD_FLAVOUR=$2	#production
XCCONFIG=$3			#productionRasp

# Ensure all cache data is removed
rm -rf build

#Rename app display name
if [ "${BUILD_FLAVOUR}" == "uat" ];then
	appName="UAT"
elif [ "${BUILD_FLAVOUR}" == "production" ]; then
	appName="Production"
fi

if [ ! -z "$appName" ];then
	perl -pi -e "s/CICD/${appName}/" "CICDDemo/Resources/Language/en.lproj/InfoPlist.strings"
	perl -pi -e "s/CICD中文/${appName}/" "CICDDemo/Resources/Language/zh-Hant.lproj/InfoPlist.strings"
fi

echo "Log: Build for archiving"
set -o pipefail && xcodebuild archive -project daasc.xcodeproj -scheme daasc -configuration $CONFIGURATION -destination 'generic/platform=iOS' -archivePath build/CICDDemo.xcarchive -derivedDataPath build/DerivedData -xcconfig CICDDemo/Resources/Configuration/$XCCONFIG.xcconfig

# Fallback rename app display name
if [ !-z "$appName" ];then
	perl -pi -e "s/${appName}/CICD/" "CICDDemo/Resources/Language/en.lproj/InfoPlist.strings"
	perl -pi -e "s/${appName}/CICD/" "CICDDemo/Resources/Language/zh-Hant.lproj/InfoPlist.strings"
fi