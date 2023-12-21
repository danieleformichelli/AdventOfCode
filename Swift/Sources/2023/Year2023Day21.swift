// Created by Daniele Formichelli.

import Utils

/// https://adventofcode.com/2023/day/21
struct Year2023Day21: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    var visited = Set<CacheKey>()
    var result = Set<Point>()
    let (start, rocks) = input.startAndRocks
    Self.solve(start: start, rocks: rocks, steps: 64, visited: &visited, result: &result)
    return result.count
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    return 0
  }
  
  static func solve(start point: Point, rocks: Set<Point>, steps: Int, visited: inout Set<CacheKey>, result: inout Set<Point>) {
    guard steps != 0 else {
      result.insert(point)
      return
    }

    let cacheKey = CacheKey(point: point, steps: steps)
    if !visited.insert(cacheKey).inserted {
      return
    }
    
    for direction in Direction.allCases {
      let nextPoint = Point(x: point.x + direction.dx, y: point.y + direction.dy)
      if !rocks.contains(nextPoint) {
        Self.solve(start: nextPoint, rocks: rocks, steps: steps - 1, visited: &visited, result: &result)
      }
    }
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
