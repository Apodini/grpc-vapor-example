// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "app",
    platforms: [
       .macOS(.v10_15),
    ],
    products: [
        .executable(name: "Run", targets: ["Run"]),
        .library(name: "App", targets: ["App"]),
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "4.0.0-rc.1"),
        .package(url: "https://github.com/vapor/fluent.git", from: "4.0.0-rc.1"),
        .package(url: "https://github.com/vapor/fluent-sqlite-driver.git", from: "4.0.0-rc.1"),
        .package(url: "https://github.com/michaelschlicker/grpc-vapor.git", .revision("59f4b66"))
    ],
    targets: [
        .target(name: "App", dependencies: [
            .product(name: "Fluent", package: "fluent"),
            .product(name: "FluentSQLiteDriver", package: "fluent-sqlite-driver"),
            .product(name: "Vapor", package: "vapor"),
            .product(name: "GRPCVapor", package: "grpc-vapor")
        ]),
        .target(name: "Run", dependencies: [
            .target(name: "App"),
        ]),
        .testTarget(name: "AppTests", dependencies: [
            .target(name: "App"),
            .product(name: "XCTVapor", package: "vapor"),
        ])
    ]
)
