// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "GDSCommon",
    defaultLocalization: "en",
    platforms: [.iOS(.v13)],
    products: [
        .library(name: "GDSCommon", targets: ["GDSCommon"]),
        .library(name: "GDSAnalytics", targets: ["GDSAnalytics"])
    ],
    dependencies: [
        .package(
            url: "https://github.com/nalexn/ViewInspector",
            .upToNextMajor(from: "0.9.7"))
    ],
    targets: [
        .target(name: "GDSCommon"),
        .testTarget(name: "GDSCommonTests",
                    dependencies: ["GDSCommon", "ViewInspector"]),
        .target(name: "GDSAnalytics",
                exclude: ["README.md"]),
        .testTarget(name: "GDSAnalyticsTests",
                    dependencies: ["GDSAnalytics"])
    ]
)
