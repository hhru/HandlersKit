// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "HandlersKit",
    platforms: [
        .iOS(.v11),
        .tvOS(.v11)
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
