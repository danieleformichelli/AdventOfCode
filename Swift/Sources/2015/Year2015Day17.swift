// Created by Daniele Formichelli.

import Parsing
import Utils

/// https://adventofcode.com/2015/day/17
struct Year2015Day17: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    return Self.combinations(containers: input.numbers, eggnog: 150).count
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    let combinations = Self.combinations(containers: input.numbers, eggnog: 150)
    let minContainersCount = combinations.map(\.count).min()!
    return combinations.filter { $0.count == minContainersCount }.count
  }

  private static func combinations(containers: [Int], eggnog: Int, chosenContainers: [Int] = []) -> [[Int]] {
    let firstContainer = containers.first!
    guard containers.count > 1 else {
      switch eggnog {
      case 0:
        return [chosenContainers]
      case firstContainer:
        return [chosenContainers + [firstContainer]]
      default:
        return []
      }
    }

    let remainingContainers = containers.dropFirst().asArray
    let combinationWithNext = Self.combinations(
      containers: remainingContainers,
      eggnog: eggnog - containers.first!,
      chosenContainers: chosenContainers + [firstContainer]
    )
    let combinationWithoutNext = Self.combinations(
      containers: remainingContainers,
      eggnog: eggnog,
      chosenContainers: chosenContainers
    )
    return combinationWithNext + combinationWithoutNext
  }
}
