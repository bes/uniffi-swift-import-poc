uniffi::setup_scaffolding!("frontend_1");

use shared_1::Shared1Enum;

#[derive(uniffi::Record, Debug)]
pub struct Frontend1Record {
    pub name: String,
}

#[uniffi::export]
fn frontend_1_function_1(shared_1: Shared1Enum, record_1: Frontend1Record) {
    println!("frontend_1_function_1 {shared_1:?} {record_1:?}");
}
