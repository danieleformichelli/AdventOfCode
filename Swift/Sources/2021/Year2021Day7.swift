// Created by Daniele Formichelli.

import Utils

/// https://adventofcode.com/2021/day/7
struct Year2021Day7: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    Self.solve(input, increasesCost: false)
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    Self.solve(input, increasesCost: true)
  }

  private static func solve(_ input: String, increasesCost: Bool) -> CustomDebugStringConvertible {
    let crabs = input.commaSeparatedNumbers.reduce(into: Dictionary<Int, Int>()) { result, index in
      result[index] = result[index, default: 0] + 1
    }
    let maxIndex = crabs.keys.max()!
    var leftCosts = Array(repeating: 0, count: maxIndex + 1)
    var leftCrabs = crabs[0] ?? 0
    var leftCrabsCost = leftCrabs
    for index in 1 ... maxIndex {
      leftCosts[index] += leftCosts[index - 1] + leftCrabsCost
      let crabsAtIndex = crabs[index] ?? 0
      leftCrabs += crabsAtIndex
      if increasesCost {
        leftCrabsCost += leftCrabs
      } else {
        leftCrabsCost = leftCrabs
      }
    }
    var rightCosts = Array(repeating: 0, count: maxIndex + 1)
    var rightCrabs = crabs[maxIndex] ?? 0
    var rightCrabsCost = rightCrabs
    for index in stride(from: maxIndex - 1, to: -1, by: -1) {
      rightCosts[index] += rightCosts[index + 1] + rightCrabsCost
      let crabsAtIndex = crabs[index] ?? 0
      rightCrabs += crabsAtIndex
      if increasesCost {
        rightCrabsCost += rightCrabs
      } else {
        rightCrabsCost = rightCrabs
      }
    }
    let costs = zip(leftCosts, rightCosts).map { $0 + $1 }
    return costs.min()!
  }
}
