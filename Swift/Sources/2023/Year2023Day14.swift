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
    
    var i = 0
    var cache: [Rocks: Int] = [:]
    while i < times {
      if let cached = cache[rocks] {
        let loopSize = i - cached
        let jumps = (times - i) / loopSize
        i += jumps * loopSize
        cache = [:]
        continue
      }
      let beforeCycle = rocks
      var rounded = rocks.rounded

      for tilt in cycle {
        let xStride: StrideThrough<Int>
        let yStride: StrideThrough<Int>
        switch tilt.dy {
        case -1:
          yStride = stride(from: maxY, through: 0, by: -1)
        case 0, 1:
          yStride = stride(from: 0, through: maxY, by: 1)
        default:
          fatalError()
        }
        switch tilt.dx {
        case -1:
          xStride = stride(from: maxX, through: 0, by: -1)
        case 0, 1:
          xStride = stride(from: 0, through: maxX, by: 1)
        default:
          fatalError()
        }
        
        if tilt.dx != 0 {
          for y in yStride {
            var sliding = 0
            for x in xStride {
              var insertAt = (x == 0 && tilt.dx == -1) || (x == maxX && tilt.dx == 1) ? x : nil
              if rounded.contains(Point(x: x, y: y)) {
                sliding += 1
                rounded.remove(Point(x: x, y: y))
              } else if rocks.cubic.contains(Point(x: x, y: y)) {
                insertAt = x - tilt.dx
              }
              if let insertAt, sliding > 0 {
                for i in 0 ..< sliding {
                  rounded.insert(Point(x: insertAt - i * tilt.dx, y: y))
                }
                sliding = 0
              }
            }
          }
        } else {
          for x in xStride {
            var sliding = 0
            for y in yStride {
              var insertAt = (y == 0 && tilt.dy == -1) || (y == maxY && tilt.dy == 1) ? y : nil
              if rounded.contains(Point(x: x, y: y)) {
                sliding += 1
                rounded.remove(Point(x: x, y: y))
              } else if rocks.cubic.contains(Point(x: x, y: y)) {
                insertAt = y - tilt.dy
              }
              if let insertAt, sliding > 0 {
                for i in 0 ..< sliding {
                  rounded.insert(Point(x: x, y: insertAt - i * tilt.dy))
                }
                sliding = 0
              }
            }
          }
        }
      }
      
      rocks = Rocks(rounded: rounded, cubic: rocks.cubic)
      cache[beforeCycle] = i
      i += 1
    }

    return rocks.rounded.map { maxY - $0.y + 1 }.sum
  }
}

struct Rocks: Hashable {
  let rounded: Set<Point>
  let cubic: Set<Point>
}

extension String {
  fileprivate var rocks: Rocks {
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
    return Rocks(rounded: rounded, cubic: cubic)
  }
}
