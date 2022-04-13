// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "NotionData",
    products: [
        .library(
            name: "NotionData",
            targets: ["NotionData"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "NotionData",
            dependencies: [],
            path: "Sources"),
    ]
)
