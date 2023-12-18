// Created by Daniele Formichelli.

import Utils

/// https://adventofcode.com/2023/day/18
struct Year2023Day18: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    return Self.solve(plan: input.digPlan)
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    return Self.solve(plan: input.digPlan2)
  }

  static func solve(plan: [Dig]) -> Int {
    var perimeter = 0
    var corners: [Point] = []
    var current = Point(x: 0, y: 0)
    for dig in plan {
      perimeter += dig.length
      corners.append(current)
      current = Point(x: current.x + dig.direction.dx * dig.length, y: current.y + dig.direction.dy * dig.length)
    }
    corners.append(Point(x: 0, y: 0))

    // Calculate area (https://en.wikipedia.org/wiki/Shoelace_formula), inclusive of edges (https://en.wikipedia.org/wiki/Pick's_theorem)
    var shoelaceArea = 0
    for i in 0 ..< corners.count - 1 {
      shoelaceArea += corners[i].x * corners[i + 1].y - corners[i].y * corners[i + 1].x
    }
    shoelaceArea = abs(shoelaceArea) / 2
    return shoelaceArea + perimeter / 2 + 1
  }
}

struct Dig {
  let direction: Direction
  let length: Int
}

extension String {
  fileprivate var digPlan: [Dig] {
    self.lines.map { line in
      let split = line.components(separatedBy: " ")
      let direction: Direction
      switch split[0] {
      case "U":
        direction = .up
      case "D":
        direction = .down
      case "L":
        direction = .left
      case "R":
        direction = .right
      default:
        fatalError()
      }
      return .init(direction: direction, length: Int(split[1])!)
    }
  }

  fileprivate var digPlan2: [Dig] {
    self.lines.map { line in
      let hex = line.components(separatedBy: "#")[1].dropLast()
      let direction: Direction
      switch hex.last {
      case "3":
        direction = .up
      case "1":
        direction = .down
      case "2":
        direction = .left
      case "0":
        direction = .right
      default:
        fatalError()
      }
      let length = Int(hex.dropLast(), radix: 16)!
      return .init(direction: direction, length: length)
    }
  }
}
