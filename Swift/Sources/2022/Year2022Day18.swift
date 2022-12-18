// Created by Daniele Formichelli.

import Utils

/// https://adventofcode.com/2022/day/18
struct Year2022Day18: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    let coordinates = input.coordinates
    var groupedByXYZ: [Int: [Int: Set<Int>]] = [:]
    for coordinate in coordinates {
      groupedByXYZ[coordinate.x, default: [:]][coordinate.y, default: []].insert(coordinate.z)
    }
    return coordinates
      .map { coordinate in
        return [
          Year2022Day18.Coordinate(x: coordinate.x - 1, y: coordinate.y, z: coordinate.z),
          Year2022Day18.Coordinate(x: coordinate.x + 1, y: coordinate.y, z: coordinate.z),
          Year2022Day18.Coordinate(x: coordinate.x, y: coordinate.y - 1, z: coordinate.z),
          Year2022Day18.Coordinate(x: coordinate.x, y: coordinate.y + 1, z: coordinate.z),
          Year2022Day18.Coordinate(x: coordinate.x, y: coordinate.y, z: coordinate.z - 1),
          Year2022Day18.Coordinate(x: coordinate.x, y: coordinate.y, z: coordinate.z + 1),
        ]
        .filter { !(groupedByXYZ[$0.x]?[$0.y]?.contains($0.z) ?? false) }
        .count
      }
      .sum
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    return 0
  }
}

extension Year2022Day18 {
  fileprivate struct Coordinate: Hashable {
    public let x: Int
    public let y: Int
    public let z: Int

    public init(x: Int, y: Int, z: Int) {
      self.x = x
      self.y = y
      self.z = z
    }
  }
}

extension String {
  fileprivate var coordinates: Set<Year2022Day18.Coordinate> {
    self.lines.map { line in
      let numbers = line.commaSeparatedNumbers
      return .init(x: numbers[0], y: numbers[1], z: numbers[2])
    }.asSet
  }
}
