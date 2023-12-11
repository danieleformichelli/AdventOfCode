// Created by Daniele Formichelli.

import Utils

/// https://adventofcode.com/2023/day/9
struct Year2023Day9: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    return input.histories.map { Self.solve(history: $0, estrapolateForward: true) }.sum
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    return input.histories.map { Self.solve(history: $0, estrapolateForward: false) }.sum
  }
  
  static func solve(history: [Int], estrapolateForward: Bool) -> Int {
    var levels = [history]
    while !levels.last!.allSatisfy({ $0 == 0 }) {
      levels.append((0 ..< levels.last!.count - 1).map {
        levels.last![$0 + 1] - levels.last![$0]
      })
    }
    var result = 0
    for level in levels.dropLast().reversed() {
      if estrapolateForward {
        result += level.last!
      } else {
        result = level.first! - result
      }
    }
    return result
  }
}

extension String {
  fileprivate var histories: [[Int]] {
    return self.lines.map { $0.spaceSeparatedNumbers }
  }
}
