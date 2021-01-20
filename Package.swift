// swift-tools-version:5.3

import PackageDescription

let package = Package(
  name: "MarkParse",
  products: [
    .library(name: "MarkParse", targets: ["MarkParse"])
  ],
  dependencies: [],
  targets: [
    .target(name: "MarkParse")
  ]
)