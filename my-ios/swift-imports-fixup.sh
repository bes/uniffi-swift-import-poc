#!/bin/bash

set -e

cd "$(cd -P -- "$(dirname -- "$0")" && pwd -P)" || exit 1

if [ -z "$XCODE_IOS_DIR" ]; then
  XCODE_IOS_DIR="../My"
fi
RUST_LIB_DIR="$XCODE_IOS_DIR/lib-my-ios"

# Fix up the UniFFI generated files (import statement missing) See https://github.com/mozilla/uniffi-rs/issues/2653
pushd "$RUST_LIB_DIR/sources/uniffi/"
find . -type f -name "*.swift" -exec sed -i '' $'s/^import Foundation$/import Foundation\\\nimport MyUniFFIModule/' {} +
popd
