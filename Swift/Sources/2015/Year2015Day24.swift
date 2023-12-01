// Created by Daniele Formichelli.

import Utils

/// https://adventofcode.com/2015/day/24
struct Year2015Day24: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    Self.run(input: input, groupsCount: 3)
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    Self.run(input: input, groupsCount: 4)
  }

  private static func run(input: String, groupsCount: Int) -> Int {
    let weights = input.numbers.asSet
    let targetWeight = weights.sum / groupsCount
    var i = 0
    while true {
      let combinations = weights.combinations(of: i)
      if let solution = combinations
        .filter({ $0.sum == targetWeight })
        .min(by: { $0.quantumEntanglement < $1.quantumEntanglement }) {
        return solution.quantumEntanglement
      }
      i += 1
    }
  }
}

extension Set where Element == Int {
  var quantumEntanglement: Int {
    return self.reduce(1) { result, value in
      let (result, overflow) = result.multipliedReportingOverflow(by: value)
      return overflow ? Int.max : result
    }
  }
}
