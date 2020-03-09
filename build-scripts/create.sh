#!/bin/bash

set -eux

readonly PROJECT=$(xcodebuild -list -json | jq '.project')
readonly CONFIGURATION="Release"
readonly NAME=$(echo ${PROJECT} | jq -r '.name')

readonly MENU=$(cat ./build-scripts/archive.json | jq)
readonly MENU_KEYS=$(echo ${MENU} | jq -r 'keys | .[]')

# Archive Project

rm -rf ./build/${CONFIGURATION}
rm -rf ./build-output/${CONFIGURATION}

frameworks=()

for KEY in ${MENU_KEYS}; do
	LABEL=$(echo ${MENU} | jq -r ".${KEY}.label")
	SCHEME=$(echo ${MENU} | jq -r ".${KEY}.scheme")
	DESTINATION=$(echo ${MENU} | jq -r ".${KEY}.destination")

	xcodebuild \
	'ENABLE_BITCODE=YES' \
	'BITCODE_GENERATION_MODE=bitcode' \
	'OTHER_CFLAGS=-fembed-bitcode' \
	'BUILD_LIBRARY_FOR_DISTRIBUTION=YES' \
	'SKIP_INSTALL=NO' \
	archive \
	-project "${NAME}.xcodeproj" \
	-scheme "${SCHEME}" \
	-destination "${DESTINATION}" \
	-configuration "${CONFIGURATION}" \
	-archivePath "./build/${CONFIGURATION}/${NAME}-${LABEL}.xcarchive"

	frameworks+=( "-framework" )
	frameworks+=( "./build/${CONFIGURATION}/${NAME}-${LABEL}.xcarchive/Products/Library/Frameworks/${SCHEME}.framework" )
done

# Create XCFramework

mkdir -p "./build-output/${CONFIGURATION}"

xcodebuild \
-create-xcframework \
${frameworks[*]} \
-output "./build-output/${CONFIGURATION}/${NAME}.xcframework"
