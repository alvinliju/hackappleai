// swift-tools-version:6.0
import PackageDescription

let package = Package(
    name: "apple-ai-experiment",
    platforms: [
       .macOS(.v13)
    ],
    dependencies: [
        // Vapor web framework
        .package(url: "https://github.com/vapor/vapor.git", from: "4.115.0"),
        // Basic templating for web pages
        .package(url: "https://github.com/vapor/leaf.git", from: "4.3.0"),
    ],
    targets: [
        .executableTarget(
            name: "hackappleai",
            dependencies: [
                .product(name: "Vapor", package: "vapor"),
                .product(name: "Leaf", package: "leaf"),
            ]
        )
    ]
)