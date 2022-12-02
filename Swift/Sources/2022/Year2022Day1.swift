// Created by Daniele Formichelli.

import Utils

/// https://adventofcode.com/2022/day/1
struct Year2022Day1: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    let calories = input.groupedNumbers
    return calories.map { $0.sum }.max()!
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    let calories = input.groupedNumbers
    return calories.map { $0.sum }.sorted().suffix(3).sum
  }
}
