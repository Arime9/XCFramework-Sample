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

# Output "lipo"

rm -rf ./build-logs/lipo/Release/lipo.txt
mkdir -p ./build-logs/lipo/Release

lipo -info ./build-output/Release/Sample.xcframework/ios-arm64/iOS.framework/iOS >> ./build-logs/lipo/Release/lipo.txt
lipo -info ./build-output/Release/Sample.xcframework/ios-x86_64-simulator/iOS.framework/iOS >> ./build-logs/lipo/Release/lipo.txt
lipo -info ./build-output/Release/Sample.xcframework/macos-x86_64/macOS.framework/macOS >> ./build-logs/lipo/Release/lipo.txt
lipo -info ./build-output/Release/Sample.xcframework/tvos-arm64/tvOS.framework/tvOS >> ./build-logs/lipo/Release/lipo.txt
lipo -info ./build-output/Release/Sample.xcframework/tvos-x86_64-simulator/tvOS.framework/tvOS >> ./build-logs/lipo/Release/lipo.txt
lipo -info ./build-output/Release/Sample.xcframework/watchos-armv7k_arm64_32/watchOS.framework/watchOS >> ./build-logs/lipo/Release/lipo.txt
lipo -info ./build-output/Release/Sample.xcframework/watchos-i386-simulator/watchOS.framework/watchOS >> ./build-logs/lipo/Release/lipo.txt

# Output "file"

rm -rf ./build-logs/file/Release/file.txt
mkdir -p ./build-logs/file/Release

file ./build-output/Release/Sample.xcframework/ios-arm64/iOS.framework/iOS >> ./build-logs/file/Release/file.txt
file ./build-output/Release/Sample.xcframework/ios-x86_64-simulator/iOS.framework/iOS >> ./build-logs/file/Release/file.txt
file ./build-output/Release/Sample.xcframework/macos-x86_64/macOS.framework/macOS >> ./build-logs/file/Release/file.txt
file ./build-output/Release/Sample.xcframework/tvos-arm64/tvOS.framework/tvOS >> ./build-logs/file/Release/file.txt
file ./build-output/Release/Sample.xcframework/tvos-x86_64-simulator/tvOS.framework/tvOS >> ./build-logs/file/Release/file.txt
file ./build-output/Release/Sample.xcframework/watchos-armv7k_arm64_32/watchOS.framework/watchOS >> ./build-logs/file/Release/file.txt
file ./build-output/Release/Sample.xcframework/watchos-i386-simulator/watchOS.framework/watchOS >> ./build-logs/file/Release/file.txt
