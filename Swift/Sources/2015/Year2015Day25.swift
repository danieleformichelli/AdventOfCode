// Created by Daniele Formichelli.

import Utils

/// https://adventofcode.com/2015/day/25
struct Year2015Day25: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    let requiredCode = input.requiredCode
    var current = Point(x: 0, y: 1)
    var value = 20_151_125
    while true {
      value = value * 252_533 % 33_554_393
      guard current != requiredCode else {
        return value
      }
      current = current.next
    }
  }

  func part2(_: String) -> CustomDebugStringConvertible {
    return ""
  }
}

extension Point {
  var next: Point {
    if self.y == 0 {
      return Point(x: 0, y: self.x + 1)
    } else {
      return Point(x: self.x + 1, y: self.y - 1)
    }
  }

  var previous: Point {
    if self.x == 0 {
      return Point(x: self.y - 1, y: 0)
    } else {
      return Point(x: self.x - 1, y: self.y + 1)
    }
  }
}

extension String {
  fileprivate var requiredCode: Point {
    let rowSplit = self.components(separatedBy: " at row ")
    let row = Int(rowSplit[0])!
    let columnSplit = rowSplit[1].components(separatedBy: " column ")
    let column = Int(rowSplit[1].dropLast())!
    return Point(x: column - 1, y: row - 1)
  }
}
