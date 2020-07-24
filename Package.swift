// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MVVMRExtensions",
    platforms: [.iOS(.v10)],
    products: [
        .library(
            name: "MVVMRExtensions",
            targets: ["MVVMRExtensions"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Moya/Moya.git", .upToNextMajor(from: "14.0.0")),
        .package(url: "https://github.com/SnapKit/SnapKit.git", .upToNextMajor(from: "5.0.1")),
        .package(url: "https://github.com/jdg/MBProgressHUD.git", .upToNextMajor(from: "1.2.0")),
        .package(url: "https://github.com/onevcat/Kingfisher.git", .upToNextMajor(from: "5.14.0")),
        .package(url: "https://github.com/SwiftyJSON/SwiftyJSON.git", .upToNextMajor(from: "5.0.0")),
        .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "5.1.1")),
        .package(url: "https://github.com/devxoul/URLNavigator.git", .upToNextMajor(from: "2.3.0")),
        .package(url: "https://gitee.com/WWDC14/SwiftyGif", .upToNextMajor(from: "5.3.0"))
    ],
    targets: [
        .target(
            name: "MVVMRExtensions",
            dependencies: [
                Target.Dependency.byName(name: "SwiftyJSON"),
                Target.Dependency.byName(name: "MBProgressHUD"),
                Target.Dependency.byName(name: "Kingfisher"),
                Target.Dependency.byName(name: "RxSwift"),
                Target.Dependency.byName(name: "SnapKit"),
                Target.Dependency.byName(name: "URLNavigator"),
                Target.Dependency.byName(name: "SwiftyGif"),
                Target.Dependency.product(name: "URLMatcher", package: "URLNavigator"),
                Target.Dependency.product(name: "RxMoya", package: "Moya"),
                Target.Dependency.product(name: "RxCocoa", package: "RxSwift")
        ],
            path: "MVVMRExtensions/Sources"),
        .testTarget(
            name: "MVVMRExtensionsTests",
            dependencies: ["MVVMRExtensions"],
            path: "MVVMRExtensions/Tests"),
    ],
    swiftLanguageVersions: [.v5]
)
