//
//  Year2021Day1.swift
//  AdventOfCode2020
//
//  Created by Daniele Formichelli on 01/12/20.
//  Copyright © 2020 Daniele Formichelli. All rights reserved.
//

import Utils

/// https://adventofcode.com/2021/day/2
struct Year2021Day2: DayBase {
  enum Direction {
    case forward(Int)
    case up(Int)
    case down(Int)

    var horizontal: Int {
      switch self {
      case .forward(let value):
        return value
      case .up, .down:
        return 0
      }
    }

    var depth: Int {
      switch self {
      case .up(let value):
        return -value
      case .down(let value):
        return value
      case .forward:
        return 0
      }
    }

    var aim: Int {
      switch self {
      case .up(let value):
        return -value
      case .down(let value):
        return value
      case .forward:
        return 0
      }
    }
  }

  func part1(_ input: String) -> CustomDebugStringConvertible {
    var horizontal = 0
    var depth = 0
    input.directions.forEach {
      horizontal += $0.horizontal
      depth += $0.depth
    }
    return horizontal * depth
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    var horizontal = 0
    var depth = 0
    var aim = 0
    input.directions.forEach {
      horizontal += $0.horizontal
      aim += $0.aim
      depth += aim * $0.horizontal
    }
    return horizontal * depth
  }
}

extension String {
  var directions: [Year2021Day2.Direction] {
    return self.lines.dropLast().map { line in
      let split = line.split(separator: " ")
      let value = Int(split[1])!
      switch split[0] {
      case "forward":
        return .forward(value)
      case "up":
        return .up(value)
      case "down":
        return .down(value)
      default:
        fatalError()
      }
    }
  }
}
