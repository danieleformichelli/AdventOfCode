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
        if !rocks.contains(nextPoint) {
          visited.insert(nextPoint)
        }
      }
    }

    var current = visited
    while remainingSteps > 0 {
      var next = Set<Point>([])
      remainingSteps -= 2
      for point in current {
        for step1 in Direction.allCases {
          let nextPoint1 = Point(x: point.x + step1.dx, y: point.y + step1.dy)
          guard !Self.isModuloRock(point: nextPoint1, rocks: rocks, modulo: modulo) else {
            continue
          }
          for step2 in Direction.allCases {
            let nextPoint2 = Point(x: nextPoint1.x + step2.dx, y: nextPoint1.y + step2.dy)
            guard !Self.isModuloRock(point: nextPoint2, rocks: rocks, modulo: modulo) else {
              continue
            }
            if remainingSteps == 2 {
              // At last 2 steps, we won't be able to go back to next point, so we shouldn't add it to visited
              if !visited.contains(nextPoint2) {
                next.insert(nextPoint2)
              }
            } else {
              if visited.insert(nextPoint2).inserted {
                next.insert(nextPoint2)
              }
            }
          }
        }
      }
      current = next
    }
    return visited.count
  }

  static func isModuloRock(point: Point, rocks: Set<Point>, modulo: Point) -> Bool {
    let x = point.x % modulo.x
    let y = point.y % modulo.y
    let moduloPoint = Point(x: x < 0 ? x + modulo.x : x, y:  y < 0 ? y + modulo.y : y)
    return rocks.contains(moduloPoint)
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
