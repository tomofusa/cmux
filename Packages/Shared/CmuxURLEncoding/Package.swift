// swift-tools-version: 6.0

import PackageDescription

// URL text encoding shared by the macOS and iOS apps. A leaf with no
// dependencies, so both the macOS browser and terminal link router and the
// iOS address bar parse links through one implementation.
let package = Package(
    name: "CmuxURLEncoding",
    platforms: [
        .macOS(.v14),
        .iOS(.v17),
    ],
    products: [
        .library(
            name: "CmuxURLEncoding",
            targets: ["CmuxURLEncoding"]
        ),
    ],
    targets: [
        .target(
            name: "CmuxURLEncoding",
            swiftSettings: [
                .swiftLanguageMode(.v6),
                .enableUpcomingFeature("ExistentialAny"),
                .enableUpcomingFeature("InternalImportsByDefault"),
            ]
        ),
        .testTarget(
            name: "CmuxURLEncodingTests",
            dependencies: ["CmuxURLEncoding"],
            swiftSettings: [
                .swiftLanguageMode(.v6),
                .enableUpcomingFeature("ExistentialAny"),
                .enableUpcomingFeature("InternalImportsByDefault"),
            ]
        ),
    ]
)
