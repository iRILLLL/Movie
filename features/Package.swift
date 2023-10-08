// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "features",
    platforms: [
        .iOS(.v15),
        .macOS(.v13),
        .tvOS(.v16),
        .watchOS(.v9),
    ],
    products: [
        .library(name: "Home", targets: ["Home"]),
        .library(name: "Trending", targets: ["Trending"]),
        .library(name: "TMDBCore", targets: ["TMDBCore"]),
        .library(name: "TMDBCoreLive", targets: ["TMDBCoreLive"]),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", exact: "1.2.0"),
        .package(url: "https://github.com/pointfreeco/swift-dependencies", exact: "1.0.0"),
        .package(url: "https://github.com/kean/Get", exact: "2.1.6"),
        .package(url: "https://github.com/pointfreeco/xctest-dynamic-overlay", from: "1.0.2"),
    ],
    targets: [
        .target(
            name: "Home",
            dependencies: [
                "TMDBCore",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ]
        ),
        .target(
            name: "Trending",
            dependencies: [
                "TMDBCore",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ]
        ),
        .target(
            name: "TMDBCore",
            dependencies: [
                .product(name: "XCTestDynamicOverlay", package: "xctest-dynamic-overlay"),
                .product(name: "Dependencies", package: "swift-dependencies"),                
            ]
        ),
        .target(
            name: "TMDBCoreLive",
            dependencies: [
                "TMDBCore",
                .product(name: "Dependencies", package: "swift-dependencies"),
                .product(name: "Get", package: "Get"),
            ]
        ),
        .testTarget(
            name: "HomeTests",
            dependencies: [
                "Home"
            ]
        ),
    ]
)
