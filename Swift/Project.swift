// Created by Daniele Formichelli.

import ProjectDescription

// MARK: - Project

let years = [2015, 2016, 2019, 2020, 2021, 2022, 2023]

func yearName(_ year: Int) -> String {
  "AdventOfCode\(year)"
}

let project = Project(
  name: "AdventOfCode",
  targets: [
    .init(
      name: "AdventOfCode",
      destinations: [.mac],
      product: .commandLineTool,
      bundleId: "df.AdventOfCode",
      infoPlist: .default,
      sources: ["Sources/Main/**"],
      dependencies: years.map { .target(name: yearName($0)) }
    ),
    .init(
      name: "Utils",
      destinations: [.mac],
      product: .staticLibrary,
      bundleId: "df.AdventOfCode.Utils",
      infoPlist: .default,
      sources: ["Sources/Utils/**"]
    ),
  ] + years.flatMap { year($0) }
)

func year(_ year: Int) -> [ProjectDescription.Target] {
  let name = yearName(year)
  return [
    .init(
      name: name,
      destinations: [.mac],
      product: .staticLibrary,
      bundleId: "df.AdventOfCode.\(name)",
      infoPlist: .default,
      sources: ["Sources/\(year)/**"],
      dependencies: [
        .target(name: "Utils"),
      ]
    ),
    .init(
      name: "\(name)Tests",
      destinations: [.mac],
      product: .unitTests,
      bundleId: "df.AdventOfCode.\(name)Tests",
      infoPlist: .default,
      sources: ["Tests/\(year)/**"],
      dependencies: [
        .target(name: name),
      ]
    ),
  ]
}
