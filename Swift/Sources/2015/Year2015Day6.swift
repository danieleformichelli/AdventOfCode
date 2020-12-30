//
//  Year2015Day6.swift
//
//  Copyright © 2020 Bending Spoons. All rights reserved.
//

import Parsing
import Utils

/// https://adventofcode.com/2015/day/6
struct Year2015Day6: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    var turnedOn: Set<Point> = []
    for instruction in input.instructions {
      for x in instruction.from.x ... instruction.to.x {
        for y in instruction.from.y ... instruction.to.y {
          let point = Point(x: x, y: y)
          switch instruction.action {
          case .toggle:
            turnedOn.formSymmetricDifference([point])
          case .on:
            turnedOn.insert(point)
          case .off:
            turnedOn.remove(point)
          }
        }
      }
    }
    return turnedOn.count
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    var brightness: [Point: Int] = [:]
    for instruction in input.instructions {
      for x in instruction.from.x ... instruction.to.x {
        for y in instruction.from.y ... instruction.to.y {
          let point = Point(x: x, y: y)
          switch instruction.action {
          case .toggle:
            brightness[point] = brightness[point, default: 0] + 2
          case .on:
            brightness[point] = brightness[point, default: 0] + 1
          case .off:
            brightness[point] = max(0, brightness[point, default: 0] - 1)
          }
        }
      }
    }
    return brightness.values.sum
  }
}

private enum Action {
  case toggle
  case on
  case off
}

private struct Instruction {
  let action: Action
  let from: Point
  let to: Point
}

extension String {
  fileprivate var instructions: [Instruction] {
    let action = StartsWith<Substring>("toggle").map { Action.toggle }
      .orElse(StartsWith("turn off").map { Action.off })
      .orElse(StartsWith("turn on").map { Action.on })
    let point = Int.parser()
      .skip(StartsWith(","))
      .take(Int.parser())
      .map { Point(x: $0, y: $1) }
    let instruction = action
      .skip(StartsWith(" "))
      .take(point)
      .skip(StartsWith(" through "))
      .take(point)
      .map { Instruction(action: $0, from: $1, to: $2) }
    return Many(instruction, separator: StartsWith("\n")).parse(self)!
  }
}
