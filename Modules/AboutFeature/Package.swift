// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "AboutFeature",
    platforms: [.iOS(.v15)],
    products: [
        .library(name: "AboutFeature", targets: ["AboutFeature"])
    ],
    dependencies: [
        .package(path: "../Common")
    ],
    targets: [
        .target(name: "AboutFeature", dependencies: ["Common"])
    ]
)
