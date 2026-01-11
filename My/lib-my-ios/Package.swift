// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "My",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "My",
            targets: ["MyIos"]),
    ],
    targets: [
		.binaryTarget(
			name: "MyRust",
			path: "./libmy_ios.xcframework",
		),
        .target(
            name: "MyFFI",
            dependencies: [.target(name: "MyRust")],
            path: "sources/uniffi",
        ),
        .target(
            name: "MyIos",
            dependencies: [.target(name: "MyFFI")],
            path: "sources/my",
        ),
    ],
    swiftLanguageModes: [.v5],
)
