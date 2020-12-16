import ProjectDescription

// MARK: - Project

let years = [2019, 2020]

func yearName(_ year: Int) -> String {
  "AdventOfCode\(year)"
}

let project = Project(
  name: "AdventOfCode",
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
    ),
    .init(
      name: "Tests",
      platform: .macOS,
      product: .unitTests,
      bundleId: "df.AdventOfCode.Tests",
      infoPlist: .default,
      sources: ["Tests/**"],
      dependencies: [
        .target(name: yearName(2019)),
        .target(name: yearName(2020)),
      ]
    ),
  ] +
    year(2019) +
    year(2020)
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
        .target(name: "Utils"),
      ]
    ),
  ]
}