// Created by Daniele Formichelli.

import Parsing
import Utils

/// https://adventofcode.com/2016/day/2
struct Year2016Day2: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    return Self.run(input: input, code: \.simpleCode)
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    return Self.run(input: input, code: \.advancedCode)
  }

  private static func run(input: String, code: (Point) -> Character?) -> String {
    var position = Point.zero
    var resultCode = ""
    for codeDirections in input.directions {
      for direction in codeDirections {
        let newPosition = position.move(direction)
        if code(newPosition) != nil {
          position = newPosition
        }
      }

      resultCode.append(code(position)!)
    }
    return resultCode
  }
}

extension Point {
  var simpleCode: Character? {
    switch self {
    case Point(x: -1, y: 1):
      return "1"
    case Point(x: 0, y: 1):
      return "2"
    case Point(x: 1, y: 1):
      return "3"
    case Point(x: -1, y: 0):
      return "4"
    case Point(x: 0, y: 0):
      return "5"
    case Point(x: 1, y: 0):
      return "6"
    case Point(x: -1, y: -1):
      return "7"
    case Point(x: 0, y: -1):
      return "8"
    case Point(x: 1, y: -1):
      return "9"
    default:
      return nil
    }
  }

  var advancedCode: Character? {
    switch self {
    case Point(x: 2, y: 2):
      return "1"
    case Point(x: 1, y: 1):
      return "2"
    case Point(x: 2, y: 1):
      return "3"
    case Point(x: 3, y: 1):
      return "4"
    case Point(x: 0, y: 0):
      return "5"
    case Point(x: 1, y: 0):
      return "6"
    case Point(x: 2, y: 0):
      return "7"
    case Point(x: 3, y: 0):
      return "8"
    case Point(x: 4, y: 0):
      return "9"
    case Point(x: 1, y: -1):
      return "A"
    case Point(x: 2, y: -1):
      return "B"
    case Point(x: 3, y: -1):
      return "C"
    case Point(x: 2, y: -2):
      return "D"
    default:
      return nil
    }
  }
}

extension String {
  fileprivate var directions: [[Direction]] {
    return self.lines.map { line in
      return line.map { direction in
        switch (direction) {
        case "U":
          return .up
        case "D":
          return .down
        case "L":
          return .left
        case "R":
          return .right
        default:
          fatalError("Unknown direction \(direction)")
        }
      }
    }
  }
}
