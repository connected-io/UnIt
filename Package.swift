// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "UnIt",
    products: [
        .library(
            name: "UnIt",
            targets: ["UnIt"]
        )
    ],
    targets: [
        .target(
            name: "UnIt",
            dependencies: [],
            path: "./UnIt/Source"
        )
    ]
)
