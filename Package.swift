// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "ClomeEcosystemKit",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
        .watchOS(.v10),
    ],
    products: [
        .library(name: "ClomeModels", targets: ["ClomeModels"]),
        .library(name: "ClomeServices", targets: ["ClomeServices"]),
        .library(name: "ClomeDesign", targets: ["ClomeDesign"]),
    ],
    dependencies: [
        .package(url: "https://github.com/firebase/firebase-ios-sdk", from: "10.19.0"),
    ],
    targets: [
        .target(
            name: "ClomeModels",
            dependencies: []
        ),
        .target(
            name: "ClomeServices",
            dependencies: [
                "ClomeModels",
                .product(name: "FirebaseAuth", package: "firebase-ios-sdk"),
            ]
        ),
        .target(
            name: "ClomeDesign",
            dependencies: ["ClomeModels"]
        ),
    ]
)
