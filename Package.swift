// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "HandlersKit",
    platforms: [
        .iOS(.v10),
        .tvOS(.v10)
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
