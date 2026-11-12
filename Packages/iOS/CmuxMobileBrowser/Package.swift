// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "CmuxMobileBrowser",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
    ],
    products: [
        .library(
            name: "CmuxMobileBrowser",
            targets: ["CmuxMobileBrowser"]
        ),
    ],
    dependencies: [
        // Localized-string helpers (`L10n`). `CmuxMobileSupport` is a leaf with
        // no dependencies, so the browser package stays low in the DAG.
        .package(path: "../CmuxMobileSupport"),
        // The URL text encoder the macOS omnibar also parses through, so a
        // `%XX` escape beside raw Unicode is not encoded again. A leaf too.
        .package(path: "../../Shared/CmuxURLEncoding"),
    ],
    targets: [
        // A self-contained, phone-local browser surface. P1 browser state never
        // touches the Mac, so this package sits low in the DAG: it depends only
        // on the leaves `CmuxMobileSupport` and `CmuxURLEncoding` and links
        // Foundation/WebKit/SwiftUI.
        .target(
            name: "CmuxMobileBrowser",
            dependencies: [
                "CmuxMobileSupport",
                "CmuxURLEncoding",
            ],
            swiftSettings: [
                .swiftLanguageMode(.v6),
                .enableUpcomingFeature("ExistentialAny"),
                .enableUpcomingFeature("InternalImportsByDefault"),
            ]
        ),
        .testTarget(
            name: "CmuxMobileBrowserTests",
            dependencies: ["CmuxMobileBrowser"],
            swiftSettings: [
                .swiftLanguageMode(.v6),
                .enableUpcomingFeature("ExistentialAny"),
                .enableUpcomingFeature("InternalImportsByDefault"),
            ]
        ),
    ]
)
