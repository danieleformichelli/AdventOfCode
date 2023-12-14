// Created by Daniele Formichelli.

import Utils

/// https://adventofcode.com/2023/day/14
struct Year2023Day14: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    return Self.solve(input: input, cycle: [(dx: 0, dy: -1)], times: 1)
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    return Self.solve(
      input: input,
      cycle: [
        (dx: 0, dy: -1),
        (dx: -1, dy: 0),
        (dx: 0, dy: 1),
        (dx: 1, dy: 0),
      ],
      times: 1000000000
    )
  }
  
  static func solve(input: String, cycle: [(dx: Int, dy: Int)], times: Int) -> Int {
    var rocks = input.rocks
    var maxX = 0
    var maxY = 0
    for rock in rocks.rounded.union(rocks.cubic) {
      maxX = max(rock.y, maxY)
      maxY = max(rock.y, maxY)
    }
    
    for i in 0 ..< times {
      for tilt in cycle {
        let xStride: StrideThrough<Int>
        let yStride: StrideThrough<Int>
        switch tilt.dy {
        case -1:
          yStride = stride(from: 1, through: maxY, by: 1)
        case 1:
          yStride = stride(from: maxY - 1, through: 0, by: -1)
        case 0:
          yStride = stride(from: 0, through: maxY, by: 1)
        default:
          fatalError()
        }
        switch tilt.dx {
        case -1:
          xStride = stride(from: 1, through: maxX, by: 1)
        case 1:
          xStride = stride(from: maxX - 1, through: 0, by: -1)
        case 0:
          xStride = stride(from: 0, through: maxX, by: 1)
        default:
          fatalError()
        }
        if tilt.dy != 0 {
          for y in yStride {
            for x in xStride {
              if rocks.rounded.contains(Point(x: x, y: y)) {
                for newY in stride(from: y + tilt.dy, through: tilt.dy > 0 ? maxY : 0, by: tilt.dy) {
                  if rocks.rounded.contains(Point(x: x, y: newY)) || rocks.cubic.contains(Point(x: x, y: newY)) {
                    break
                  }
                  rocks.rounded.remove(Point(x: x, y: newY - tilt.dy))
                  rocks.rounded.insert(Point(x: x, y: newY))
                }
              }
            }
          }
        } else {
          for x in xStride {
            for y in yStride {
              if rocks.rounded.contains(Point(x: x, y: y)) {
                for newX in stride(from: x + tilt.dx, through: tilt.dx > 0 ? maxX : 0, by: tilt.dx) {
                  if rocks.rounded.contains(Point(x: newX, y: y)) || rocks.cubic.contains(Point(x: newX, y: y)) {
                    break
                  }
                  rocks.rounded.remove(Point(x: newX - tilt.dx, y: y))
                  rocks.rounded.insert(Point(x: newX, y: y))
                }
              }
            }
          }
        }
      }
    }
      
    return rocks.rounded.map { maxY - $0.y + 1 }.sum
  }
}

struct Input {
  let value: Int
}

extension String {
  fileprivate var rocks: (rounded: Set<Point>, cubic: Set<Point>) {
    var rounded = Set<Point>()
    var cubic = Set<Point>()
    for (y, line) in self.lines.enumerated() {
      for (x, value) in line.enumerated() {
        switch value {
        case ".":
          continue
        case "O":
          rounded.insert(Point(x: x, y: y))
        case "#":
          cubic.insert(Point(x: x, y: y))
        default:
          fatalError()
        }
      }
    }
    return (rounded: rounded, cubic: cubic)
  }
}
