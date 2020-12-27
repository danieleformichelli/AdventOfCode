import ProjectDescription

// MARK: - Project

let years = [2015, 2019, 2020]

func yearName(_ year: Int) -> String {
  "AdventOfCode\(year)"
}

let project = Project(
  name: "AdventOfCode",
  packages: [
    .package(url: "https://github.com/pointfreeco/swift-parsing", .upToNextMajor(from: "0.1.0")),
  ],
  targets: [
    .init(
      name: "AdventOfCode",
      platform: .macOS,
      product: .commandLineTool,
      bundleId: "df.AdventOfCode",
      infoPlist: .default,
      sources: ["Sources/Main/**"],
      dependencies: years.map { .target(name: yearName($0)) }
    ),
    .init(
      name: "Utils",
      platform: .macOS,
      product: .staticLibrary,
      bundleId: "df.AdventOfCode.Utils",
      infoPlist: .default,
      sources: ["Sources/Utils/**"]
    )
  ] + years.flatMap { year($0) }
)

func year(_ year: Int) -> [ProjectDescription.Target] {
  let name = yearName(year)
  return [
    .init(
      name: name,
      platform: .macOS,
      product: .staticLibrary,
      bundleId: "df.AdventOfCode.\(name)",
      infoPlist: .default,
      sources: ["Sources/\(year)/**"],
      dependencies: [
        .package(product: "Parsing"),
        .target(name: "Utils"),
      ]
    ),
    .init(
      name: "\(name)Tests",
      platform: .macOS,
      product: .unitTests,
      bundleId: "df.AdventOfCode.\(name)Tests",
      infoPlist: .default,
      sources: ["Tests/\(year)/**"],
      dependencies: [
        .target(name: name)
      ]
    )
  ]
}
