// Created by Daniele Formichelli.

import Utils

/// https://adventofcode.com/2015/day/20
struct Year2015Day20: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    let minPresents = Int(input)!
    var index = 1
    while true {
      let totalPresents = 10 * index.divisors().sum

      guard totalPresents < minPresents else {
        return index
      }

      index += 1
    }
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    let minPresents = Int(input)!
    var index = 1
    while true {
      let totalPresents = 11 * index.divisors().filter { index / $0 <= 50 }.sum

      guard totalPresents < minPresents else {
        return index
      }

      index += 1
    }
  }
}
