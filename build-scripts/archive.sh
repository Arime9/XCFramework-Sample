#!/bin/bash

set -eu

rm -rf ./build

readonly PROJECT=$(xcodebuild -list -json | jq '.project')
readonly CONFIGURATION=$(echo ${PROJECT} | jq -r '.Release')
readonly NAME=$(echo ${PROJECT} | jq -r '.name')

readonly MENU=$(cat ./build-scripts/archive.json | jq)
readonly MENU_KEYS=$(echo ${MENU} | jq -r 'keys | .[]')

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
	-archivePath "./build/${NAME}-${LABEL}.xcarchive"
done
