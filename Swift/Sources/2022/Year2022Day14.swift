// Created by Daniele Formichelli.

import Foundation
import Utils

/// https://adventofcode.com/2022/day/14
struct Year2022Day14: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    return Self.solve(input: input, withBottom: false)
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    return Self.solve(input: input, withBottom: true)
  }

  static func solve(input: String, withBottom: Bool) -> Int {
    var rocks: Set<Point> = []
    for rockLine in input.rockLines {
      var current = rockLine[0]
      rocks.insert(current)
      for nextPoint in rockLine.dropFirst() {
        let dx = nextPoint.x - current.x != 0 ? (nextPoint.x - current.x) / abs(nextPoint.x - current.x) : 0
        let dy = nextPoint.y - current.y != 0 ? (nextPoint.y - current.y) / abs(nextPoint.y - current.y) : 0
        while current != nextPoint {
          current = .init(x: current.x + dx, y: current.y + dy)
          rocks.insert(current)
        }
      }
    }
    let lowerRockY = rocks.map { $0.y }.max()! + (withBottom ? 2 : 0)

    var pouredSand = 0
    while true {
      var newSand = Point(x: 500, y: 0)
      nextPosition: while true {
        guard newSand.y != lowerRockY else {
          return pouredSand
        }

        if !withBottom || newSand.y != lowerRockY - 1 {
          let possibleNextPositions = [
            Point(x: newSand.x, y: newSand.y + 1),
            Point(x: newSand.x - 1, y: newSand.y + 1),
            Point(x: newSand.x + 1, y: newSand.y + 1),
          ]
          for possibleNextPosition in possibleNextPositions {
            if !rocks.contains(possibleNextPosition) {
              newSand = possibleNextPosition
              continue nextPosition
            }
          }
        }
        pouredSand += 1
        rocks.insert(newSand)
        if newSand == Point(x: 500, y: 0) {
          return pouredSand
        }
        break
      }
    }
  }
}

extension String {
  var rockLines: Set<[Point]> {
    return self.lines.map { line in
      let points = line.split(separator: " -> ")
      return points.map { point in
        let split = point.split(separator: ",")
        return Point(x: Int(String(split[0]))!, y: Int(String(split[1]))!)
      }
    }.asSet
  }
}
