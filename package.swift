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
        .iOS(.v13) // Specify the minimum iOS version you want to support
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

