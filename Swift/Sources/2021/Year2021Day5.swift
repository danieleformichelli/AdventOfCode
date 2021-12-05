// Created by Daniele Formichelli.

import Utils

/// https://adventofcode.com/2021/day/5
struct Year2021Day5: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    Self.solve(input: input, includeDiagonal: false)
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    Self.solve(input: input, includeDiagonal: true)
  }

  private static func solve(input: String, includeDiagonal: Bool) -> CustomDebugStringConvertible {
    var grid: [Point: Int] = [:]
    for vent in input.parsedInput {
      guard includeDiagonal || vent.from.x == vent.to.x || vent.from.y == vent.to.y else {
        continue
      }

      let xDiff = vent.to.x - vent.from.x
      let dx = xDiff != 0 ? xDiff / abs(xDiff) : 0
      let yDiff = vent.to.y - vent.from.y
      let dy = yDiff != 0 ? yDiff / abs(yDiff) : 0
      var current = vent.from
      while current != vent.to {
        grid[current] = grid[current, default: 0] + 1
        current = Point(x: current.x + dx, y: current.y + dy)
      }
      grid[current] = grid[current, default: 0] + 1
    }

    return grid
      .values
      .filter { $0 >= 2 }
      .count
  }
}

extension Year2021Day5 {
  struct Input {
    let from: Point
    let to: Point
  }
}

extension String {
  fileprivate var parsedInput: [Year2021Day5.Input] {
    self.lines.map { line in
      let components = line.components(separatedBy: " -> ")
      let fromComponents = components[0].split(separator: ",")
      let toComponents = components[1].split(separator: ",")
      return .init(
        from: .init(x: Int(fromComponents[0])!, y: Int(fromComponents[1])!),
        to: .init(x: Int(toComponents[0])!, y: Int(toComponents[1])!)
      )
    }
  }
}
