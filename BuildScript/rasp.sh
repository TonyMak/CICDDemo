#!/bin/bash
set -e

BUILD_FLAVOUR=$1
XCCONFIG=$2

PATH_CONFIG_XML="path_of_rasp_config"
if [[ $BUILD_FLAVOUR != "uat" ]]; then
	PATH_CONFIG_XML="another_path_of_config"
fi

SHIELDER="jar_file_of_rasp"
IPA_NAME="ipa_file_position"
SHIELDED_IPA_NAME="new_ipa_position_after_protected"

java -jar $SHIELDER --standalone --config $PATH_CONFIG_XML -o $SHIELDED_IPA_NAME $IPA_NAME
mv -f $SHIELDED_IPA_NAME $IPA_NAME