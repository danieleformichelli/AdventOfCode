// Created by Daniele Formichelli.

import Parsing
import Utils

/// https://adventofcode.com/2015/day/18
struct Year2015Day18: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    Self.run(input: input, alwaysOn: [])
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    Self.run(input: input, alwaysOn: [.init(x: 0, y: 0), .init(x: 99, y: 0), .init(x: 0, y: 99), .init(x: 99, y: 99)])
  }

  private static func run(input: String, alwaysOn: Set<Point>) -> Int {
    var lightsOn = input.lightsOn.union(alwaysOn)
    (1 ... 100).forEach { _ in
      var neighborsOn: [Point: Int] = [:]
      for light in lightsOn {
        for neighbor in light.neighbors {
          neighborsOn[neighbor] = neighborsOn[neighbor, default: 0] + 1
        }
      }

      for row in 0 ..< 100 {
        for column in 0 ..< 100 {
          let point = Point(x: column, y: row)
          guard !alwaysOn.contains(point) else { continue }

          if lightsOn.contains(point) {
            if neighborsOn[point] != 2, neighborsOn[point] != 3 {
              lightsOn.remove(point)
            }
          } else {
            if neighborsOn[point] == 3 {
              lightsOn.insert(point)
            }
          }
        }
      }
    }
    return lightsOn.count
  }
}

extension String {
  fileprivate var lightsOn: Set<Point> {
    var lightsOn: Set<Point> = []
    self.lines.enumerated().forEach { row, line in
      line.enumerated().forEach { column, element in
        guard element == "#" else { return }
        lightsOn.insert(.init(x: column, y: row))
      }
    }
    return lightsOn
  }
}
