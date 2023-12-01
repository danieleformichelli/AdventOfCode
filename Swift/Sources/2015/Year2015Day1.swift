// Created by Daniele Formichelli.

import Utils

/// https://adventofcode.com/2015/day/1
struct Year2015Day1: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    var floor = 0
    input.directions.forEach {
      switch $0 {
      case .up:
        floor += 1
      case .down:
        floor -= 1
      }
    }
    return floor
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    let directions = input.directions
    var floor = 0
    var index = 0
    while floor != -1 {
      switch directions[index] {
      case .up:
        floor += 1
      case .down:
        floor -= 1
      }
      index += 1
    }
    return index
  }
}

private enum Direction: String {
  case up = "("
  case down = ")"
}

extension String {
  fileprivate var directions: [Direction] {
    return self.map { $0 == "{" ? Direction.up : Direction.down }
  }
}
