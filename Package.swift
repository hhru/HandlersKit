// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "HandlersKit",
    platforms: [
        .iOS(.v12),
        .tvOS(.v12)
    ],
    products: [
        .library(
            name: "HandlersKit",
            targets: ["HandlersKit"]
        )
    ],
    targets: [
        .target(
            name: "HandlersKit",
            path: "Sources"
        ),
        .testTarget(
            name: "HandlersKitTests",
            dependencies: ["HandlersKit"],
            path: "Tests"
        )
    ],
    swiftLanguageVersions: [.v5]
)
