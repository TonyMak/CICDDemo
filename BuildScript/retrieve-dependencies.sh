#!/bin/bash
set -e

XCODE=$1
BUILD_FLAVOUR=$2

echo "Log: Retrieve dependencies with Xcode="$XCODE" Flavour="$BUILD_FLAVOUR

# Implementation of installing dependencies from Git clone / Nexus download

# Special handling by parameter received
if [[ $BUILD_FLAVOUR != "uat" ]]; then
	# Example of customisation
fi