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

# Output "file"

rm -rf ./build-logs/file/Release/file.txt
mkdir -p ./build-logs/file/Release

file ./build-output/Release/Sample.xcframework/ios-arm64/iOS.framework/iOS >> ./build-logs/file/Release/file.txt
file ./build-output/Release/Sample.xcframework/ios-arm64_x86_64-simulator/iOS.framework/iOS >> ./build-logs/file/Release/file.txt
file ./build-output/Release/Sample.xcframework/macos-arm64_x86_64/macOS.framework/macOS >> ./build-logs/file/Release/file.txt
file ./build-output/Release/Sample.xcframework/tvos-arm64/tvOS.framework/tvOS >> ./build-logs/file/Release/file.txt
file ./build-output/Release/Sample.xcframework/tvos-arm64_x86_64-simulator/tvOS.framework/tvOS >> ./build-logs/file/Release/file.txt
file ./build-output/Release/Sample.xcframework/watchos-arm64_32_armv7k/watchOS.framework/watchOS >> ./build-logs/file/Release/file.txt
file ./build-output/Release/Sample.xcframework/watchos-arm64_x86_64-simulatorwatchOS.framework/watchOS >> ./build-logs/file/Release/file.txt

# Output "lipo"

rm -rf ./build-logs/lipo/Release/info.txt
mkdir -p ./build-logs/lipo/Release

lipo -info ./build-output/Release/Sample.xcframework/ios-arm64/iOS.framework/iOS >> ./build-logs/lipo/Release/info.txt
lipo -info ./build-output/Release/Sample.xcframework/ios-arm64_x86_64-simulator/iOS.framework/iOS >> ./build-logs/lipo/Release/info.txt
lipo -info ./build-output/Release/Sample.xcframework/macos-arm64_x86_64/macOS.framework/macOS >> ./build-logs/lipo/Release/info.txt
lipo -info ./build-output/Release/Sample.xcframework/tvos-arm64/tvOS.framework/tvOS >> ./build-logs/lipo/Release/info.txt
lipo -info ./build-output/Release/Sample.xcframework/tvos-arm64_x86_64-simulator/tvOS.framework/tvOS >> ./build-logs/lipo/Release/info.txt
lipo -info ./build-output/Release/Sample.xcframework/watchos-arm64_32_armv7k/watchOS.framework/watchOS >> ./build-logs/lipo/Release/info.txt
lipo -info ./build-output/Release/Sample.xcframework/watchos-arm64_x86_64-simulator/watchOS.framework/watchOS >> ./build-logs/lipo/Release/info.txt

# Output "otool"

rm -rf ./build-logs/otool/Release
mkdir -p ./build-logs/otool/Release

otool -arch arm64 -l ./build-output/Release/Sample.xcframework/ios-arm64/iOS.framework/iOS > ./build-logs/otool/Release/ios-arm64-load-commands.txt
otool -arch arm64 -l ./build-output/Release/Sample.xcframework/ios-arm64_x86_64-simulator/iOS.framework/iOS > ./build-logs/otool/Release/ios-arm64-simulator-load-commands.txt
otool -arch x86_64 -l ./build-output/Release/Sample.xcframework/ios-arm64_x86_64-simulator/iOS.framework/iOS > ./build-logs/otool/Release/ios-x86_64-simulator-load-commands.txt
otool -arch arm64 -l ./build-output/Release/Sample.xcframework/macos-arm64_x86_64/macOS.framework/macOS > ./build-logs/otool/Release/macos-arm64-load-commands.txt
otool -arch x86_64 -l ./build-output/Release/Sample.xcframework/macos-arm64_x86_64/macOS.framework/macOS > ./build-logs/otool/Release/macos-x86_64-load-commands.txt
otool -arch arm64 -l ./build-output/Release/Sample.xcframework/tvos-arm64/tvOS.framework/tvOS > ./build-logs/otool/Release/tvos-arm64-load-commands.txt
otool -arch arm64 -l ./build-output/Release/Sample.xcframework/tvos-arm64_x86_64-simulator/tvOS.framework/tvOS > ./build-logs/otool/Release/tvos-arm64-simulator-load-commands.txt
otool -arch x86_64 -l ./build-output/Release/Sample.xcframework/tvos-arm64_x86_64-simulator/tvOS.framework/tvOS > ./build-logs/otool/Release/tvos-x86_64-simulator-load-commands.txt
otool -arch arm64_32 -l ./build-output/Release/Sample.xcframework/watchos-arm64_32_armv7k/watchOS.framework/watchOS > ./build-logs/otool/Release/watchos-arm64_32-load-commands.txt
otool -arch armv7k -l ./build-output/Release/Sample.xcframework/watchos-arm64_32_armv7k/watchOS.framework/watchOS > ./build-logs/otool/Release/watchos-armv7k-load-commands.txt
otool -arch arm64 -l ./build-output/Release/Sample.xcframework/watchos-arm64_x86_64-simulator/watchOS.framework/watchOS > ./build-logs/otool/Release/watchos-arm64-simulator-load-commands.txt
otool -arch x86_64 -l ./build-output/Release/Sample.xcframework/watchos-arm64_x86_64-simulator/watchOS.framework/watchOS > ./build-logs/otool/Release/watchos-x86_64-simulator-load-commands.txt
