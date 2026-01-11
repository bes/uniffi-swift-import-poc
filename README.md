# UniFFI Swift import PoC

Proof-of-Concept for UniFFI issue https://github.com/mozilla/uniffi-rs/issues/2653 

## Instructions

### Build
Build UniFFI project using `my-ios/build.sh debug` (already done and commited)

### Open XCode
Open XCode project `My` - see that the local package dependency "My" source
file `sources/uniffi/frontend_1` has several errors, for example
`Cannot find type 'RustBuffer' in scope`.

### "Fix" the project
Fix the project by running the script `my-ios/swift-imports-fixup.sh`

## Another notable detail

Also note that the crate `frontend/frontend-2` exports a UniFFI function, but
it is not included in the `My/lib-my-ios/sources/uniffi/` sources. This is
because `my-ios/src/lib.rs` does not refer to the crate by code, but it is
included in Cargo.toml.
