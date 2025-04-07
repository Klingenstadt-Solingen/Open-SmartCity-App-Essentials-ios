// swift-tools-version:5.9
// The swift-tools-version declares the minimum version of Swift required to build this package

import PackageDescription

/// use local package path
let packageLocal: Bool = false


let deviceKitVersion = Version("5.0.0")
let swiftDateVersion = Version("7.0.0")
let matomoVersion = Version("7.7.0")

let package = Package(
  name: "OSCAEssentials",
  defaultLocalization: "de",
  platforms: [
    .iOS(.v13),
    .macOS(.v10_15),
    .watchOS(.v6),
    .tvOS(.v13)
  ],
  products: [
    // Products define the executables and libraries a package produces, and make them visible to other packages.
    .library( name: "OSCAEssentials",
              targets: ["OSCAEssentials"]),
  ],// end products
  dependencies: [
    // Dependencies declare other packages that this package depends on.
    /* DeviceKit */
    Package.Dependency.package( url: "https://github.com/devicekit/DeviceKit.git",
                                .upToNextMinor(from: deviceKitVersion)),
    /* SwiftDate */
    Package.Dependency.package( url: "https://github.com/malcommac/SwiftDate.git",
                                .upToNextMinor(from: swiftDateVersion)),
    Package.Dependency.package(url: "https://github.com/parse-community/Parse-SDK-iOS-OSX.git", exact: "4.1.1"),
    /* Matomo */
    Package.Dependency.package(url: "https://github.com/matomo-org/matomo-sdk-ios.git", .upToNextMinor(from: matomoVersion))
  ],// end dependencies
  targets: [
    // Targets are the basic building blocks of a package. A target can define a module or a test suite.
    // Targets can depend on other targets in this package, and on products in packages this package depends on.
    .target(
      name: "OSCAEssentials",
      dependencies: [ .product(name: "DeviceKit",
                               package: "DeviceKit"),
                      .product(name: "SwiftDate",
                               package: "SwiftDate"),
                      .product(name: "ParseObjC", package: "Parse-SDK-iOS-OSX"),
                      .product(name: "MatomoTracker", package: "matomo-sdk-ios")],
      path: "OSCAEssentials/OSCAEssentials",
      exclude: ["Info.plist",
                "SupportingFiles/Production-Sample.xcconfig",
                "SupportingFiles/API_Release-Sample.plist",
                "SupportingFiles/API_Develop-Sample.plist",
                "SupportingFiles/Development-Sample.xcconfig"],
      resources: [.process("Resources")]),
      /*
    .binaryTarget(
      name: "OSCAEssentialsBin",
      url: "https://github.com/op"
    ),
    */
    .testTarget(
      name: "OSCAEssentialsTests",
      dependencies: ["OSCAEssentials"],
      path: "OSCAEssentials/OSCAEssentialsTests",
      exclude: ["Info.plist"],
      resources: [.process("Resources")]),
  ]// end targets
)// end Package
