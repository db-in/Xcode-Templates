import PackageDescription

let package = Package(
    name: "___PACKAGENAME___",
    products: [
        .library(
            name: "___PACKAGENAME___",
            targets: ["___PACKAGENAME___"]
        ),
    ],
    targets: [
        .target(
            name: "___PACKAGENAME___",
            dependencies: []
        ),
        .testTarget(
            name: "___PACKAGENAME___Tests",
            dependencies: ["___PACKAGENAME___"]
        ),
    ]
)
