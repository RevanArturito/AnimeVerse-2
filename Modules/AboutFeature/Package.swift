// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "AboutFeature",
    platforms: [.iOS(.v15)],
    products: [
        .library(name: "AboutFeature", targets: ["AboutFeature"])
    ],
    dependencies: [
        .package(url: "https://github.com/RevanArturito/AnimeVerse-Common.git", from: "1.0.3")
    ],
    targets: [
        .target(name: "AboutFeature", dependencies: [
            .product(name: "Common", package: "AnimeVerse-Common")
        ])
    ]
)
