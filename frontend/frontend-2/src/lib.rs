uniffi::setup_scaffolding!("frontend_2");

use shared_1::Shared2Enum;

#[uniffi::export]
fn frontend_2_function_1(shared_2: Shared2Enum) {
    println!("frontend_2_function_1 {shared_2:?}");
}
