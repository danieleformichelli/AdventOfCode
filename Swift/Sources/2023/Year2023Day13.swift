// Created by Daniele Formichelli.

import Utils

/// https://adventofcode.com/2023/day/13
struct Year2023Day13: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    Self.solve(patterns: input.patterns, requiresSmudge: false)
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    Self.solve(patterns: input.patterns, requiresSmudge: true)
  }

  static func solve(patterns: [Set<Point>], requiresSmudge: Bool) -> Int {
    var result = 0
    for pattern in patterns {
      var maxX = 0
      var maxY = 0
      for rock in pattern {
        maxX = max(rock.x, maxX)
        maxY = max(rock.y, maxY)
      }

      for x in 1 ... maxX {
        if Self.verticalMirror(rocks: pattern, requiresSmudge: requiresSmudge, x: x, maxX: maxX, maxY: maxY) {
          result += x
          break
        }
      }

      for y in 1 ... maxY {
        if Self.horizontalMirror(rocks: pattern, requiresSmudge: requiresSmudge, y: y, maxX: maxX, maxY: maxY) {
          result += 100 * y
          break
        }
      }
    }
    return result
  }

  static func verticalMirror(rocks: Set<Point>, requiresSmudge: Bool, x: Int, maxX: Int, maxY: Int) -> Bool {
    var smudgeFound = false
    var dx = 1
    while x - dx >= 0 && x + dx <= maxX + 1 {
      for y in 0 ... maxY {
        if rocks.contains(Point(x: x - dx, y: y)) != rocks.contains(Point(x: x + dx - 1, y: y)) {
          if requiresSmudge && !smudgeFound {
            smudgeFound = true
            continue
          }
          return false
        }
      }
      dx += 1
    }
    return !requiresSmudge || smudgeFound
  }

  static func horizontalMirror(rocks: Set<Point>, requiresSmudge: Bool, y: Int, maxX: Int, maxY: Int) -> Bool {
    var smudgeFound = false
    var dy = 1
    while y - dy >= 0 && y + dy <= maxY + 1 {
      for x in 0 ... maxX {
        if rocks.contains(Point(x: x, y: y - dy)) != rocks.contains(Point(x: x, y: y + dy - 1)) {
          if requiresSmudge && !smudgeFound {
            smudgeFound = true
            continue
          }
          return false
        }
      }
      dy += 1
    }
    return !requiresSmudge || smudgeFound
  }
}

extension String {
  fileprivate var patterns: [Set<Point>] {
    return self.groupedLines.map { groupedLines in
      var rocks = Set<Point>()
      for (y, line) in groupedLines.enumerated() {
        for (x, char) in line.enumerated() {
          switch char {
          case "#":
            rocks.insert(Point(x: x, y: y))
          case ".":
            break
          default:
            fatalError()
          }
        }
      }
      return rocks
    }
  }
}
