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
    var holes: [Point: Hole] = [:]
    var last: (point: Point, direction: Direction) = (point: Point(x: 0, y: 0), direction: .up)
    for dig in plan {
      holes[Point(x: last.point.x, y: last.point.y)] = dig.direction.hole(from: last.direction)
      for _ in 0 ..< dig.length {
        let point = Point(x: last.point.x + dig.direction.dx, y: last.point.y - dig.direction.dy)
        let hole = dig.direction.hole(from: dig.direction)
        holes[point] = hole
        last = (point: point, direction: dig.direction)
      }
    }
    var inside: Set<Point> = []
    var minX: Int = 0
    var minY: Int = 0
    var maxX: Int = Int.min
    var maxY: Int = Int.min
    for hole in holes.keys {
      minX = min(minX, hole.x)
      minY = min(minY, hole.y)
      maxX = max(maxX, hole.x)
      maxY = max(maxY, hole.y)
    }
    for y in minY ..< maxY {
      var comingFromNorth: Bool? = nil
      var walls = 0
      for x in minX ..< maxX {
        let point = Point(x: x, y: y)
        if let hole = holes[point] {
          switch hole {
          case .NS:
            walls += 1
          case .NW, .NE:
            if let unwrappedComingFromNorth = comingFromNorth {
              if !unwrappedComingFromNorth {
                walls += 1
              }
              comingFromNorth = nil
            } else {
              comingFromNorth = true
            }
          case .SW, .SE:
            if let unwrappedComingFromNorth = comingFromNorth {
              if unwrappedComingFromNorth {
                walls += 1
              }
              comingFromNorth = nil
            } else {
              comingFromNorth = false
            }
          case .WE:
            break
          }
        } else {
          if walls % 2 == 1 {
            inside.insert(point)
          }
        }
      }
    }
    return holes.count + inside.count
  }
}

enum Hole: String {
  case NW = "J"
  case NE = "L"
  case NS = "|"
  case WE = "-"
  case SW = "7"
  case SE = "F"
}

extension Direction {
  func hole(from: Direction) -> Hole {
    switch (self, from) {
    case (.up, .up), (.up, .down), (.down, .up), (.down, .down):
      return .NS
    case (.left, .left), (.left, .right), (.right, .left), (.right, .right):
      return .WE
    case (.down, .left), (.right, .up):
      return .NW
    case (.down, .right), (.left, .up):
      return .NE
    case (.up, .left), (.right, .down):
      return .SW
    case (.up, .right), (.left, .down):
      return .SE
    }
  }
}
struct Dig {
  let direction: Direction
  let length: Int
  let color: String
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
      return .init(direction: direction, length: Int(split[1])!, color: "")
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
      return .init(direction: direction, length: length, color: "")
    }
  }
}
