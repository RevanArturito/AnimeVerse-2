// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "DetailFeature",
    platforms: [.iOS(.v15)],
    products: [
        .library(name: "DetailFeature", targets: ["DetailFeature"])
    ],
    dependencies: [
        .package(url: "https://github.com/RevanArturito/AnimeVerse-Core.git", from: "1.0.1"),
        .package(url: "https://github.com/RevanArturito/AnimeVerse-Common.git", from: "1.0.3"),
        .package(url: "https://github.com/onevcat/Kingfisher.git", from: "7.11.0")
    ],
    targets: [
        .target(name: "DetailFeature", dependencies: [
            .product(name: "Core", package: "AnimeVerse-Core"),
            .product(name: "Common", package: "AnimeVerse-Common"),
            "Kingfisher"
        ]),
        .testTarget(name: "DetailFeatureTests", dependencies: ["DetailFeature"])
    ]
)
