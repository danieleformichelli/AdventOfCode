//
//  Year2015Day25.swift
//
//  Copyright © 2020 Bending Spoons. All rights reserved.
//

import Parsing
import Utils

/// https://adventofcode.com/2015/day/25
struct Year2015Day25: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    let requiredCode = input.requiredCode
    var current = Point(x: 0, y: 1)
    var value = 20151125
    while true {
      value = value * 252533 % 33554393
      guard current != requiredCode else {
        return value
      }
      current = current.next
    }
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
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
    let point = Skip(StartsWith("To continue, please consult the code grid in the manual.  Enter the code at row "))
      .take(Int.parser())
      .skip(StartsWith(", column "))
      .take(Int.parser())
      .skip(StartsWith("."))
      .map { Point(x: $1, y: $0) }
    let oneBased = point.parse(self)!
    return Point(x: oneBased.x - 1, y: oneBased.y - 1)
  }
}
