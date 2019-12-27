// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "Teams",
    products: [
        .library(name: "Teams", targets: ["App"]),
    ],
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0"),

        // 📚 A library for working with the MLB Lookup Service
        .package(url: "https://github.com/spprichard/MLBScrapperLib.git", from:"0.0.5"),
        
        // 🏬 A package for working with a Postgress Database
        .package(url: "https://github.com/vapor/fluent-postgresql.git", from: "1.0.0"),
    ],
    targets: [
        .target(name: "App", dependencies: ["Vapor", "MLBScrapperLib", "FluentPostgreSQL"]),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: ["App"])
    ]
)

