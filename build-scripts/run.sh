#!/bin/bash

set -eux

# Output "xcodebuild -list" to text

rm -rf ./build-logs/project-settings
mkdir -p ./build-logs/project-settings

xcodebuild -list -json > ./build-logs/project-settings/Sample.json

# Output "xcodebuild -showBuildSettings" to text

rm -rf ./build-logs/build-settings/archive
mkdir -p ./build-logs/build-settings/archive

xcodebuild -showBuildSettings -json -project Sample.xcodeproj -scheme iOS archive > ./build-logs/build-settings/archive/iOS.json
xcodebuild -showBuildSettings -json -project Sample.xcodeproj -scheme macOS archive > ./build-logs/build-settings/archive/macOS.json
xcodebuild -showBuildSettings -json -project Sample.xcodeproj -scheme tvOS archive > ./build-logs/build-settings/archive/tvOS.json
xcodebuild -showBuildSettings -json -project Sample.xcodeproj -scheme watchOS archive > ./build-logs/build-settings/archive/watchOS.json

# Create an XCFramework

bash ./build-scripts/create.sh

# Output "tree"

rm -rf ./build-logs/tree/Release
mkdir -p ./build-logs/tree/Release

tree ./build/Release > ./build-logs/tree/Release/build.txt
tree ./build-output/Release > ./build-logs/tree/Release/build-output.txt
