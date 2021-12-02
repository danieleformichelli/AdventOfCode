// Created by Daniele Formichelli.

import Utils

/// https://adventofcode.com/2021/day/1
struct Year2021Day1: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    let inputNumbers = input.numbers
    var previous = Int.max
    return inputNumbers
      .filter {
        let increases = $0 > previous
        previous = $0
        return increases
      }
      .count
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    let inputNumbers = input.numbers
    var previous = inputNumbers.prefix(3)
    return inputNumbers
      .dropFirst(3)
      .filter {
        let previousWindow = previous.sum
        previous = previous.dropFirst()
        previous.append($0)
        let currentWindow = previous.sum
        let increases = currentWindow > previousWindow
        return increases
      }
      .count
  }
}
