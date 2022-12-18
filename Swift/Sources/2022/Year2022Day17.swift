// Created by Daniele Formichelli.

import Utils

/// https://adventofcode.com/2022/day/17
struct Year2022Day17: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    return Self.solve(input: input, rocksCount: 2022)
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    return Self.solve(input: input, rocksCount: 1000000000000)
  }

  static func solve(input: String, rocksCount: Int) -> Int {
    var height = 0
    let directions = input.directions
    var rocks: Set<Point> = [
      .init(x: 0, y: height),
      .init(x: 1, y: height),
      .init(x: 2, y: height),
      .init(x: 3, y: height),
      .init(x: 4, y: height),
      .init(x: 5, y: height),
      .init(x: 6, y: height),
    ]

    var i = -1
    for rockIndex in 0 ..< rocksCount {
      let shape = Self.shapes[rockIndex % Self.shapes.count]
      var position = Point(
        x: 2,
        y: height + 3 + shape.height
      )
      while true {
        i += 1
        let direction = directions[i % directions.count]
        let nextPosition = position.move(direction)
        if nextPosition.x >= 0 && nextPosition.x + shape.width <= 7, shape.canMove(to: nextPosition, in: rocks) {
          position = nextPosition
        }
        let downPosition = position.move(.down)
        if shape.canMove(to: downPosition, in: rocks) {
          position = downPosition
        } else {
          rocks.formUnion(shape.rocks(from: position))
          height = max(height, position.y)
          break
        }
      }
    }
    return height
  }

  static var shapes: [Shape] {
    return [
      .init(rocks: [
        .init(x: 0, y: 0),
        .init(x: 1, y: 0),
        .init(x: 2, y: 0),
        .init(x: 3, y: 0),
      ]),
      .init(rocks: [
        .init(x: 1, y: 0),
        .init(x: 0, y: -1),
        .init(x: 1, y: -1),
        .init(x: 2, y: -1),
        .init(x: 1, y: -2),
      ]),
      .init(rocks: [
        .init(x: 2, y: 0),
        .init(x: 2, y: -1),
        .init(x: 0, y: -2),
        .init(x: 1, y: -2),
        .init(x: 2, y: -2),
      ]),
      .init(rocks: [
        .init(x: 0, y: 0),
        .init(x: 0, y: -1),
        .init(x: 0, y: -2),
        .init(x: 0, y: -3),
      ]),
      .init(rocks: [
        .init(x: 0, y: 0),
        .init(x: 1, y: 0),
        .init(x: 0, y: -1),
        .init(x: 1, y: -1),
      ])
    ]
  }
}

extension Year2022Day17 {
  struct Shape {
    let rocks: [Point]
    let topLeftX: Int
    let width: Int
    let height: Int

    init(rocks: [Point]) {
      self.rocks = rocks
      self.topLeftX = rocks.filter { $0.y == 0 }.map(\.x).min()!
      self.width = rocks.map(\.x).max()! + 1
      self.height = -(rocks.map(\.y).min()! - 1)
    }

    func rocks(from position: Point) -> [Point] {
      return self.rocks.map { .init(x: position.x + $0.x, y: position.y + $0.y) }
    }

    func canMove(to position: Point, in rocks: Set<Point>) -> Bool {
      return self.rocks(from: position).allSatisfy({!rocks.contains($0)})
    }
  }
}

extension String {
  fileprivate var directions: [Direction] {
    return self.map { char in
      switch char {
      case "^":
        return .up
      case ">":
        return .right
      case "v":
        return .down
      case "<":
        return .left
      default:
        fatalError("Invalid char \(char)")
      }
    }
  }
}
