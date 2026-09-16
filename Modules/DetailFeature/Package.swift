// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "DetailFeature",
    platforms: [.iOS(.v15)],
    products: [
        .library(name: "DetailFeature", targets: ["DetailFeature"])
    ],
    dependencies: [
        .package(path: "../Core"),
        .package(path: "../Common"),
        .package(url: "https://github.com/onevcat/Kingfisher.git", from: "7.11.0")
    ],
    targets: [
        .target(name: "DetailFeature", dependencies: ["Core", "Common", "Kingfisher"]),
        .testTarget(name: "DetailFeatureTests", dependencies: ["DetailFeature"])
    ]
)
