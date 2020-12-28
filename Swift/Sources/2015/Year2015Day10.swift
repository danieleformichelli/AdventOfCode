//
//  Year2015Day10.swift
//
//  Copyright © 2020 Bending Spoons. All rights reserved.
//

import Parsing
import Utils

/// https://adventofcode.com/2015/day/10
struct Year2015Day10: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    return Self.run(input: input, times: 40)
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    return Self.run(input: input, times: 50)
  }

  static private func run(input: String, times: Int) -> Int {
    var result = input
    (1 ... times).forEach { _ in
      result = Self.lookAndSay(result)
    }
    return result.count
  }

  static private func lookAndSay(_ input: String) -> String {
    var current = input.first!
    var count = 1
    var index = input.index(after: input.startIndex)
    var result = ""
    while index != input.endIndex {
      let character = input[index]
      if character == current {
        count += 1
      } else {
        result.append(String(count))
        result.append(current)
        current = character
        count = 1
      }
      index = input.index(after: index)
    }
    result.append(String(count))
    result.append(current)
    return result
  }
}
