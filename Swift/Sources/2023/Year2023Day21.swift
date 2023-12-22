// Created by Daniele Formichelli.

import Utils

/// https://adventofcode.com/2023/day/21
struct Year2023Day21: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    return Self.solve(input: input, steps: 64)
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    return Self.solve(input: input, steps: 26501365)
  }
  
  static func solve(input: String, steps: Int) -> Int {
    let (start, rocks) = input.startAndRocks
    var maxX = 0
    var maxY = 0
    for rock in rocks {
      maxX = max(maxX, rock.x)
      maxY = max(maxY, rock.y)
    }
    let modulo = Point(x: maxX, y: maxY)
    

    var visited = Set<Point>([])
    var remainingSteps: Int
    if steps % 2 == 0 {
      remainingSteps = steps
      visited.insert(start)
    } else {
      remainingSteps = steps - 1
      for direction in Direction.allCases {
        let nextPoint = Point(x: start.x + direction.dx, y: start.y + direction.dy)
        visited.insert(nextPoint)
      }
    }
    
    var current = visited
    while remainingSteps > 0 {
      var next = Set<Point>([])
      remainingSteps -= 2
      for point in current {
        for step1 in Direction.allCases {
          guard let nextPoint1 = Self.modulo(point: point, rocks: rocks, modulo: modulo, direction: step1) else {
            continue
          }
          for step2 in Direction.allCases {
            guard let nextPoint2 = Self.modulo(point: nextPoint1, rocks: rocks, modulo: modulo, direction: step2) else {
              continue
            }
            if visited.insert(nextPoint2).inserted {
              next.insert(nextPoint2)
            }
          }
        }
      }
      current = next
    }
    return visited.count
  }
  
  static func modulo(point: Point, rocks: Set<Point>, modulo: Point, direction: Direction) -> Point? {
    let x = (point.x + direction.dx) % modulo.x
    let y = (point.y + direction.dy) % modulo.y
    let moduloNextPoint = Point(x: x < 0 ? x + modulo.x : x, y: y)
    guard !rocks.contains(moduloNextPoint) else { return nil }
    return moduloNextPoint
  }
}

struct CacheKey: Hashable {
  let point: Point
  let steps: Int
}

extension String {
  fileprivate var startAndRocks: (start: Point, rocks: Set<Point>) {
    var start = Point(x: 0, y: 0)
    var rocks = Set<Point>([])
    self.lines.enumerated().forEach { y, line in
      line.enumerated().forEach { x, value in
        switch value {
        case "S":
          start = Point(x: x, y: y)
        case "#":
          rocks.insert(Point(x: x, y: y))
        default:
          break
        }
      }
    }
    return (start: start, rocks: rocks)
  }
}
