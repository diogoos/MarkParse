// swift-tools-version:5.3

import PackageDescription

let package = Package(
  name: "MarkParse",
  platforms: [.iOS(.v9), .macOS(.v10_12), .tvOS(.v9)],
  products: [
    .library(name: "MarkParse", targets: ["MarkParse"])
  ],
  dependencies: [],
  targets: [
    .target(name: "MarkParse")
  ]
)
