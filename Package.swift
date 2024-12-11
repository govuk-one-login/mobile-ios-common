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
                 .upToNextMajor(from: .init(0, 10, 1)))
    ],
    targets: [
        .target(name: "GDSCommon"),
        .testTarget(name: "GDSCommonTests",
                    dependencies: ["GDSCommon", "ViewInspector"])
    ]
)
