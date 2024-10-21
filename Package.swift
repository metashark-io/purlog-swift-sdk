//
//  Package.swift
//  PurLog
//
//  Created by Grant Espanet on 8/19/24.
//


// swift-tools-version:6.0
import PackageDescription

let package = Package(
    name: "PurLog",
    platforms: [
        .iOS(.v14),         // Minimum iOS version
        .macOS(.v12),    // Minimum macOS version
        .watchOS(.v8),      // Minimum watchOS version
        .tvOS(.v15),        // Minimum tvOS version
        .visionOS(.v1)      // Minimum visionOS version
    ],
    products: [
        .library(
            name: "PurLog",
            targets: ["PurLog"]),
    ],
    targets: [
        .target(
            name: "PurLog",
            path: "PurLog"), // This should point to the directory containing your source code
        .testTarget(
            name: "PurLogTests",
            dependencies: ["PurLog"],
            path: "PurLogTests"),
    ]
)
