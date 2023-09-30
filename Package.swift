// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Colour",
  platforms: [.iOS(.v16), .macOS(.v14)],
  products: [
    .library(
      name: "Colour",
      targets: ["Colour"]
    ),
  ],
  dependencies: [
    .package(url: "https://github.com/GoodHatsLLC/SwiftLintFix.git", from: "0.1.8")
      .contingent(on: Env.requiresSwiftLintFixPlugin),
  ].compactMap { $0 },
  targets: [
    .target(
      name: "Colour",
      dependencies: ["NativeKit"],
      swiftSettings: [
        .enableUpcomingFeature("ConciseMagicFile"),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("StrictConcurrency"),
        .enableUpcomingFeature("ImplicitOpenExistentials"),
        .enableUpcomingFeature("BareSlashRegexLiterals"),
        .enableUpcomingFeature("ForwardTrailingClosures"),
      ]
    ),
    .testTarget(
      name: "ColourTests",
      dependencies: ["Colour"]
    ),
    .target(
      name: "NativeKit"
    ),
    .testTarget(
      name: "NativeKitTests",
      dependencies: ["NativeKit"]
    ),
  ]
)

// MARK: - Conditional Dependency Setup
import Foundation

// MARK: - ConditionalArtifact

private protocol ConditionalArtifact { }
extension ConditionalArtifact {
  func contingent(on filter: Bool) -> Self? {
    if filter {
      return self
    } else {
      return nil
    }
  }
}

// MARK: - Package.Dependency + ConditionalArtifact

extension Package.Dependency: ConditionalArtifact { }

// MARK: - Target + ConditionalArtifact

extension Target: ConditionalArtifact { }

// MARK: - Product + ConditionalArtifact

extension Product: ConditionalArtifact { }

// MARK: - Env

private enum Env {
  static let requiresSwiftLintFixPlugin: Bool = {
    ProcessInfo.processInfo.environment["ENABLE_LINT_FIX"] == "1"
  }()
}
