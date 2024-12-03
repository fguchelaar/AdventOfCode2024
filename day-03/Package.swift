// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "day-03",
  dependencies: [
    .package(name: "AdventKit", path: "../AdventKit")
  ],
  targets: [
    .executableTarget(
      name: "day-03",
      dependencies: ["AdventKit"],
      resources: [.copy("../input.txt")]
    ),
    .testTarget(
      name: "Tests",
      dependencies: ["day-03"]
    ),
  ]
)
