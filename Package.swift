// swift-tools-version:4.2
import PackageDescription

let package = Package(
    name: "Imperio",
    products: [
        .library(name: "Imperio", targets: ["Imperio"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Imperio",
            dependencies: [],
            path: "Frameworks/Imperio"
        )
    ]
)
