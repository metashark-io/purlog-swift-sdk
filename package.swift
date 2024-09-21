//
//  package.swift
//  PurLog
//
//  Created by Grant Espanet on 8/19/24.
//


// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "PurLog",
    platforms: [
        .iOS(.v14),         // Minimum iOS version
        .macOS(.v12),    // Minimum macOS version
        .watchOS(.v8_5),      // Minimum watchOS version
        .tvOS(.v15_5),        // Minimum tvOS version
        .visionOS(.v1_2)      // Minimum visionOS version
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
