// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CTrainDelays",
    platforms: [
        .iOS(.v15),
        .macOS(.v12)
    ],
    dependencies: [],
    targets: [
        .executableTarget(
            name: "CTrainDelays_VSCode",
            dependencies: []
        ),
    ]
)
