// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "FavoriteFeature",
    platforms: [.iOS(.v15)],
    products: [
        .library(name: "FavoriteFeature", targets: ["FavoriteFeature"])
    ],
    dependencies: [
        .package(url: "https://github.com/RevanArturito/AnimeVerse-Core.git", from: "1.0.1"),
        .package(url: "https://github.com/RevanArturito/AnimeVerse-Common.git", from: "1.0.3"),
        .package(path: "../DetailFeature")
    ],
    targets: [
        .target(name: "FavoriteFeature", dependencies: [
            .product(name: "Core", package: "AnimeVerse-Core"),
            .product(name: "Common", package: "AnimeVerse-Common"),
            "DetailFeature" 
        ]),
        .testTarget(name: "FavoriteFeatureTests", dependencies: ["FavoriteFeature"])
    ]
)
