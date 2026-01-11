uniffi::setup_scaffolding!("shared_1");

#[derive(uniffi::Enum, Debug)]
pub enum Shared1Enum {
    Variant1,
    Variant2
}

#[derive(uniffi::Enum, Debug)]
pub enum Shared2Enum {
    Variant1,
    Variant2
}

#[uniffi::export]
fn shared_function_1(shared_1: Shared1Enum, shared_2: Shared2Enum) {
    println!("shared_function_1 {shared_1:?} {shared_2:?}");
}
