// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MVVM-Navigator-Extensions",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "MVVM-Navigator-Extensions",
            targets: ["MVVM-Navigator-Extensions"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Moya/Moya.git", .upToNextMajor(from: "14.0.0")),
        .package(url: "https://github.com/SnapKit/SnapKit.git", .upToNextMajor(from: "5.0.1")),
        .package(url: "https://github.com/jdg/MBProgressHUD.git", .upToNextMajor(from: "1.2.0")),
        .package(url: "https://github.com/onevcat/Kingfisher.git", .upToNextMajor(from: "5.14.0")),
        .package(url: "https://github.com/SwiftyJSON/SwiftyJSON.git", .upToNextMajor(from: "5.0.0")),
        .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "5.1.1")),
        .package(url: "https://github.com/devxoul/URLNavigator.git", .upToNextMajor(from: "2.3.0"))
    ],
    targets: [
        .target(
            name: "MVVM-Navigator-Extensions",
            dependencies: [
                Target.Dependency.byName(name: "SwiftyJSON"),
                Target.Dependency.byName(name: "MBProgressHUD"),
                Target.Dependency.byName(name: "Kingfisher"),
                Target.Dependency.byName(name: "RxSwift"),
                Target.Dependency.byName(name: "SnapKit"),
                Target.Dependency.byName(name: "URLNavigator"),
                Target.Dependency.product(name: "URLMatcher", package: "URLNavigator"),
                Target.Dependency.product(name: "RxMoya", package: "Moya"),
                Target.Dependency.product(name: "RxCocoa", package: "RxSwift")
            ],
            path: "MVVM-Navigator-Extensions/Sources"
        ),
        .testTarget(
            name: "MVVM-Navigator-ExtensionsTests",
            dependencies: ["MVVM-Navigator-Extensions"]),
    ]
)
