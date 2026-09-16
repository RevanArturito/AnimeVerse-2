// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "Common",
    defaultLocalization: "en",
    platforms: [.iOS(.v15)],
    products: [
        .library(name: "Common", targets: ["Common"])
    ],
    dependencies: [
        .package(path: "../Core")
    ],
    targets: [
        .target(name: "Common", dependencies: ["Core"]),
        .testTarget(name: "CommonTests", dependencies: ["Common"])
    ]
)
