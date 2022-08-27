// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "BuildTools",
    products: [
        .library(name: "BuildTools", targets: ["BuildTools"]),
    ],
    dependencies: [
        .package(url: "https://github.com/nicklockwood/SwiftFormat.git", from: "0.49.17"),
    ],
    targets: [
        .target(name: "BuildTools", dependencies: []),
    ]
)
