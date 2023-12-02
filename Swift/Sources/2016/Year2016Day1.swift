// Created by Daniele Formichelli.

import Utils

/// https://adventofcode.com/2016/day/1
struct Year2016Day1: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    Self.run(input: input, stopOnRevisit: false)
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    Self.run(input: input, stopOnRevisit: true)
  }

  private static func run(input: String, stopOnRevisit: Bool) -> Int {
    var direction = Direction.up
    var position = Point.zero
    var visited: Set<Point> = []
    outer: for instruction in input.instructions {
      switch instruction.rotation {
      case .left:
        direction = direction.turnLeft
      case .right:
        direction = direction.turnRight
      }

      for _ in 1 ... instruction.distance {
        if visited.contains(position), stopOnRevisit {
          break outer
        }
        visited.insert(position)
        position = position.move(direction)
      }
    }
    return position.manhattanDistance(from: .zero)
  }
}

private struct Instruction {
  enum Rotation {
    case left
    case right
  }

  let rotation: Rotation
  let distance: Int
}

extension String {
  fileprivate var instructions: [Instruction] {
    return self.components(separatedBy: ", ").map { Instruction(rotation: $0.first == "R" ? .right : .left, distance: Int(String($0.dropFirst()))!) }
  }
}
