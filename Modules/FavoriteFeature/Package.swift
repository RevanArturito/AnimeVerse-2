// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "FavoriteFeature",
    platforms: [.iOS(.v15)],
    products: [
        .library(name: "FavoriteFeature", targets: ["FavoriteFeature"])
    ],
    dependencies: [
        .package(path: "../Core"),
        .package(path: "../Common"),
        .package(path: "../DetailFeature")
    ],
    targets: [
        .target(name: "FavoriteFeature", dependencies: ["Core", "Common", "DetailFeature"]),
        .testTarget(name: "FavoriteFeatureTests", dependencies: ["FavoriteFeature"])
    ]
)
