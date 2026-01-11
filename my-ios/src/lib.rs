use frontend_1::Frontend1Record;
use shared_1::{Shared1Enum, Shared2Enum};

uniffi::setup_scaffolding!("ffi");

#[uniffi::export]
fn ios_function_1(shared_1: Shared1Enum, shared_2: Shared2Enum, record_1: Frontend1Record) {
    println!("ios_function_1 {shared_1:?} {shared_2:?} {record_1:?}");
}
