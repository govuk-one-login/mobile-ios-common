// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "GDSCommon",
    defaultLocalization: "en",
    platforms: [.iOS(.v16)],
    products: [
        .library(name: "GDSCommon", targets: ["GDSCommon"])
    ],
    dependencies: [
        .package(url: "https://github.com/nalexn/ViewInspector",
                 .upToNextMajor(from: "0.10.3"))
    ],
    targets: [
        .target(name: "GDSCommon"),
        .testTarget(name: "GDSCommonTests",
                    dependencies: ["GDSCommon", "ViewInspector"])
    ]
)
