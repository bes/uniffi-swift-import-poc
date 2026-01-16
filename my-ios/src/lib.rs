uniffi::setup_scaffolding!("ffi");

#[uniffi::export]
fn ios_function_1() {
    println!("ios_function_1");
}
