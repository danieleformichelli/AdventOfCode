// Created by Daniele Formichelli.

import Utils

/// https://adventofcode.com/2021/day/6
struct Year2021Day6: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    return Self.solve(input: input, days: 80)
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    return Self.solve(input: input, days: 256)
  }

  static func solve(input: String, days: Int) -> CustomDebugStringConvertible {
    let newRegenerationTime = 8
    let regenerationTime = 6
    var counts = input.commaSeparatedNumbers.reduce(into: Array(repeating: 0, count: newRegenerationTime + 1)) { result, count in
      result[count] = result[count] + 1
    }
    for index in 0 ..< days {
      let currentDayIndex = index % counts.count
      let nextCreateIndex = (currentDayIndex + regenerationTime + 1) % counts.count
      counts[nextCreateIndex] = counts[nextCreateIndex] + counts[currentDayIndex]
    }

    return counts.sum
  }
}

extension Year2021Day6 {
  struct Input {
    let value: Int
  }
}

extension String {
  fileprivate var parsedInput: [Year2021Day6.Input] {
    self.lines.map { line in
      return .init(value: Int(line)!)
    }
  }
}
