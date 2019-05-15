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
            path: "./UnIt/Source"
            dependencies: []
        )
    ]
)