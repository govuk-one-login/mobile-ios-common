// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "GDSCommon",
    defaultLocalization: "en",
    platforms: [.iOS(.v13)],
    products: [
        .library(name: "GDSCommon", targets: ["GDSCommon"])
    ],
    dependencies: [
        .package(url: "https://github.com/nalexn/ViewInspector",
                 .upToNextMajor(from: "0.10.2"))
    ],
    targets: [
        .target(name: "GDSCommon"),
        .testTarget(name: "GDSCommonTests",
                    dependencies: ["GDSCommon", "ViewInspector"])
    ]
)
