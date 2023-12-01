// Created by Daniele Formichelli.

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
    return self.lines.map {
      let split = $0.components(separatedBy: " ")
      let action: Action
      switch split[0] {
      case "toggle":
        action = Action.toggle
      case "turn off":
        action = Action.off
      case "turn on":
        action = Action.on
      default:
        fatalError("Unknown action \(split[0])")
      }
      let fromSplit = split[1].components(separatedBy: ",")
      let from = Point(x: Int(fromSplit[0])!, y: Int(fromSplit[1])!)
      let toSplit = split[3].components(separatedBy: ",")
      let to = Point(x: Int(toSplit[0])!, y: Int(toSplit[1])!)
      return Instruction(action: action, from: from, to: to)
    }
  }
}
