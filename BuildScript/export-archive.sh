#!/bin/bash
set -e

# Suppose pass default value as following comment
CONFIGURATION=$1	#Release
BUILD_FLAVOUR=$2	#production
XCCONFIG=$3			#productionRasp

ARCHIVEPATH="build/CICDDemo.xcarchive"
EXPORTPATH="build/$XCCONFIG"
EXPORTPLIST="BuildScripts/export/export-options-$BUILD_FLAVOUR.plist"
DSYM=$ARCHIVEPATH"/dSYMs/CICDDemo.app.dSYM"

set -o pipefail && xcodebuild -exportArchive -archivePath $ARCHIVEPATH -exportPath $EXPORTPATH -exportOptionsPlist $EXPORTPLIST