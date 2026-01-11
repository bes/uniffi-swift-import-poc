#!/bin/bash

set -e

cd "$(cd -P -- "$(dirname -- "$0")" && pwd -P)" || exit 1

if [ -z "$XCODE_IOS_DIR" ]; then
  XCODE_IOS_DIR="../My"
fi
RUST_LIB_DIR="$XCODE_IOS_DIR/lib-my-ios"
RUST_LIB_NAME="libmy_ios.a"

if [ ! -d "$XCODE_IOS_DIR" ]; then
  echo "$XCODE_IOS_DIR does not exist."
  exit 2
fi

mkdir -p "./target/simulator-ios/release"
mkdir -p "./target/simulator-ios/debug"
mkdir -p "$RUST_LIB_DIR/sources"

case "$1" in
  "debug")
    cargo build --target aarch64-apple-ios
    cargo build --target aarch64-apple-ios-sim
    build_arch="aarch64-apple-ios"
    build_target="debug"
    ;;
  "release")
    cargo build --release --target aarch64-apple-ios
    cargo build --release --target aarch64-apple-ios-sim
    build_arch="aarch64-apple-ios"
    build_target="release"
    ;;
  *)
    echo "Select a build type: debug | release"
    exit 1
    ;;
esac

pushd ../uniffi/
# Remove old generated cruft
rm -rf "../my-ios/target/my-generated/"
# Let UniFFI generate sources, headers, and modulemaps
cargo run --bin uniffi-swift \
          -- \
          "../my-ios/target/$build_arch/$build_target/$RUST_LIB_NAME" "../my-ios/target/my-generated/uniffi" \
          --swift-sources \
          --headers \
          --modulemap \
          --module-name MyUniFFIModule \
          --modulemap-filename module.modulemap
popd

# Clean up some old trash
rm -rf "$RUST_LIB_DIR/libs"
rm -rf "$RUST_LIB_DIR/framework"
rm -rf "$RUST_LIB_DIR/sources/uniffi"
mkdir -p "$RUST_LIB_DIR/sources/uniffi"

# Move the UniFFI generated files to the right place in the Swift Package
mv ./target/my-generated/uniffi/*.swift "$RUST_LIB_DIR/sources/uniffi/"

rm -rf "$RUST_LIB_DIR/libmy_ios.xcframework"

# Create an XCFramework and put it in the right place
case "$1" in
  "debug")
    xcodebuild -create-xcframework \
      -library "./target/aarch64-apple-ios/debug/$RUST_LIB_NAME" -headers "./target/my-generated/uniffi/" \
      -library "./target/aarch64-apple-ios-sim/debug/$RUST_LIB_NAME" -headers "./target/my-generated/uniffi/" \
      -output "$RUST_LIB_DIR/libmy_ios.xcframework"
    ;;
  "release")
    xcodebuild -create-xcframework \
      -library "./target/aarch64-apple-ios/release/$RUST_LIB_NAME" -headers "./target/my-generated/uniffi/" \
      -library "./target/aarch64-apple-ios-sim/release/$RUST_LIB_NAME" -headers "./target/my-generated/uniffi/" \
      -output "$RUST_LIB_DIR/libmy_ios.xcframework"
    ;;
  *)
    echo "Oops how did this happen?"
    exit 1
    ;;
esac
