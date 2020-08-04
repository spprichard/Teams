// swift-tools-version:5.2
import PackageDescription

let package = Package(
    name: "Teams",
    platforms: [
       .macOS(.v10_15)
    ],
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "4.27.1"),
        // 📚 A library for working with the MLB Lookup Service
        .package(url: "https://github.com/spprichard/MLBScrapperLib.git", from:"0.0.8"),
        // 🐬 The defualt ORM for Vapor Apps
        .package(url: "https://github.com/vapor/fluent.git", from: "4.0.0"),
        // 🏬 A package for working with a Postgress Database
        .package(url: "https://github.com/vapor/fluent-postgres-driver.git", from: "2.0.0"),
    ],
    targets: [
        .target(
            name: "App",
            dependencies: [
                .product(name: "Vapor", package: "vapor"),
                .product(name: "Fluent", package: "fluent"),
                .product(name: "MLBScrapperLib", package: "MLBScrapperLib"),
                .product(name: "FluentPostgresDriver", package: "fluent-postgres-driver")
            ],
            swiftSettings: [
                // Enable better optimizations when building in Release configuration. Despite the use of
                // the `.unsafeFlags` construct required by SwiftPM, this flag is recommended for Release
                // builds. See <https://github.com/swift-server/guides#building-for-production> for details.
                .unsafeFlags(["-cross-module-optimization"], .when(configuration: .release))
            ]
        ),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: ["App"])
    ]
)

