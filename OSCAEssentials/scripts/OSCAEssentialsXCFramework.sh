#!/bin/bash
# Type a script or drag a script file from your workspace to insert its path.
# https://stackoverflow.com/questions/9850936/what-permissions-are-required-for-run-script-during-a-build-phase
# path to oscanetworkservice-ios root dir
#  ./scripts/OSCAEssentialsXCFramework.sh \
#    $(pwd) \
#    'Debug' \
#    ~/Library/Developer/Xcode/DerivedData/OSCAEssentials-dgdhyrhybiaupcfengworindlkkp/Build \
#    'OSCAEssentials' \
# first argument: "root path"
echo 'XCWorkspace root path: ' $1
# second argument: "configuration ('Debug' / 'Release')"
echo 'Second arg: ' $2
# third argument: build path
echo 'build path: ' $3
# fourth argument: project / scheme name
echo 'project / scheme name: ' $4

# .../DerivedData/OSCAEssentials.../Build
BUILD_PATH=$3
# OSCAEssentials
PROJECT_NAME=$4
if [ "$2" = "Debug" ]; then
  OUTPUT_PATH=$BUILD_PATH/Products/Debug-iphonesimulator/PROJECT_NAME.o
else 
  OUTPUT_PATH=$BUILD_PATH/Products/Release-iphonesimulator/PROJECT_NAME.o
fi # end if Debug

if [[ -n "$BUILD_PATH" ]]; then
  if [[ -n "$1" ]]; then
    if [ "$2" = "Debug" ]; then
      echo "Debug configuration"
      echo "archive ${PROJECT_NAME} for iOS Simulator"
      xcodebuild archive \
        -scheme $PROJECT_NAME \
        -configuration Debug \
        -destination 'generic/platform=iOS Simulator' \
        -archivePath "./build/${PROJECT_NAME}.framework-iphonesimulator.xcarchive" \
        -quiet \
        SKIP_INSTALL=NO \
        BUILD_LIBRARIES_FOR_DISTRIBUTION=YES
      echo "archive ${PROJECT_NAME} for generic iphoneos"
      xcodebuild archive \
        -scheme $PROJECT_NAME \
        -configuration Debug \
        -destination 'generic/platform=iOS' \
        -archivePath "./build/${PROJECT_NAME}.framework-iphoneos.xcarchive" \
        -quiet \
        SKIP_INSTALL=NO \
        BUILD_LIBRARIES_FOR_DISTRIBUTION=YES
      echo "merging to ${PROJECT_NAME} xcframework"
      xcodebuild -create-xcframework \
        -framework "./build/${PROJECT_NAME}.framework-iphonesimulator.xcarchive/Products/Library/Frameworks/${PROJECT_NAME}.framework" \
        -framework "./build/${PROJECT_NAME}.framework-iphoneos.xcarchive/Products/Library/Frameworks/${PROJECT_NAME}.framework" \
        -output "./build/${PROJECT_NAME}.xcframework"
      if [ $? = 0 ]; then
        echo '🟢 Build succeeded!'
      else
        echo '🔴 Build failed!'
      fi # end if build succcessful
    else
      echo 'Release configuration'
      xcodebuild \
        -scheme "OSCAEssentials" \
        -destination 'platform=iOS Simulator,name=iPhone 14,OS=16.1' \
        -sdk iphoneos \
        -configuration Release \
        -quiet \
        ARCHS="arm64"
    fi # end if debug
  else 
    echo "🔴Missing Workspace root path!"
  fi # end if workspace path
else
  echo "🔴Wrong build path!"
fi # end if build path
