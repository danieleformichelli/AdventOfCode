// Created by Daniele Formichelli.

import Utils

/// https://adventofcode.com/2019/day/1
struct Year2019Day1: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    input.numbers.map { Self.requiredFuel(for: $0) }.sum
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    input.numbers.map { Self.totalRequiredFuel(for: $0) }.sum
  }
}

extension Year2019Day1 {
  private static func requiredFuel(for mass: Int) -> Int {
    mass / 3 - 2
  }

  private static func totalRequiredFuel(for mass: Int) -> Int {
    let partialRequiredFuelMass = Self.requiredFuel(for: mass)
    guard partialRequiredFuelMass > 0 else { return 0 }
    return partialRequiredFuelMass + Self.totalRequiredFuel(for: partialRequiredFuelMass)
  }
}
