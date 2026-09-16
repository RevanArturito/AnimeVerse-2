// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "HomeFeature",
    platforms: [.iOS(.v15)],
    products: [
        .library(name: "HomeFeature", targets: ["HomeFeature"])
    ],
    dependencies: [
        .package(path: "../Core"),
        .package(path: "../Common"),
        .package(path: "../DetailFeature")
    ],
    targets: [
        .target(name: "HomeFeature", dependencies: ["Core", "Common", "DetailFeature"]),
        .testTarget(name: "HomeFeatureTests", dependencies: ["HomeFeature"])
    ]
)
