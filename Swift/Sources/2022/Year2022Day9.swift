// Created by Daniele Formichelli.

import Foundation
import Utils

/// https://adventofcode.com/2022/day/9
struct Year2022Day9: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    return Self.solve(input: input, knots: 2)
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    return Self.solve(input: input, knots: 10)
  }

  static func solve(input: String, knots: Int) -> Int {
    var knots = Array(repeating: Point(x: 0, y: 0), count: knots)
    var visited: Set<Point> = [knots.last!]
    for move in input.moves {
      for _ in 0 ..< move.steps {
        knots[0] = .init(x: knots[0].x + move.direction.dx, y: knots[0].y + move.direction.dy)
        for i in 1 ..< knots.count {
          let next = knots[i - 1]
          let current = knots[i]
          if abs(next.x - current.x) > 1 || abs(next.y - current.y) > 1 {
            let dx = next.x - current.x != 0 ? (next.x - current.x) / abs(next.x - current.x) : 0
            let dy = next.y - current.y != 0 ? (next.y - current.y) / abs(next.y - current.y) : 0
            knots[i] = .init(x: current.x + dx, y: current.y + dy)
          }
          visited.insert(knots.last!)
        }
      }
    }
    return visited.count
  }
}

extension String {
  var moves: [(direction: Direction, steps: Int)] {
    return self.lines.map { line in
      let split = line.split(separator: " ")
      return (direction: .init(rawValue: String(split[0]))!, steps: Int(split[1])!)
    }
  }
}
