#!/bin/bash
set -e

CONFIGURATION=$1
DESTINATION=$2

if [ -z "$DESTINATION" ]; then
DESTINATION="generic/platform=iOS"
fi

# Choose your target path. For this demo, all dependencies is put in `Submodules`
cd Submodules

# Example for building necessary library into pipeline
echo "Log: Retrieve and build CleanSwiftDemo"
rm -rf CleanSwiftDemo-master
#Clone from master
git clone https://github.com/TonyMak/CleanSwiftDemo.git
# Or you could also clone neccessay branch / tag
# git clone https://github.com/TonyMak/CleanSwiftDemo.git -b 1.0
set -o pipefail && xcodebuild -project CleanSwiftDemo-master/CleanSwiftDemo.xcodeproj -scheme CleanSwiftDemo -derivedDataPath CleanSwiftDemo-master/build/DerivedData -configuration $CONFIGURATION -destination "$DESTINATION"
cp -rf CleanSwiftDemo-master/build/DerivedData/Build/Products/**/CleanSwiftDemo.framework/ CleanSwiftDemo-master/build/CleanSwiftDemo.framework/
rm -rf CleanSwiftDemo-master/build/DerivedData