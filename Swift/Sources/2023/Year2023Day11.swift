// Created by Daniele Formichelli.

import Utils

/// https://adventofcode.com/2023/day/11
struct Year2023Day11: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    return Self.solve(input: input, expandBy: 1)
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    return Self.solve(input: input, expandBy: 999999)
  }
  
  static func solve(input: String, expandBy: Int) -> Int {
    let galaxies = input.galaxies(expandBy: expandBy).asArray
    var totalDistance = 0
    for i in 0 ..< galaxies.count {
      for j in i ..< galaxies.count {
        totalDistance += galaxies[i].manhattanDistance(from: galaxies[j])
      }
    }
    return totalDistance
  }
}

extension String {
  fileprivate func galaxies(expandBy: Int) -> Set<Point> {
    let lines = self.lines
    let emptyRows = lines.enumerated().filter { _, line in line.allSatisfy({ $0 == "." })}.map { $0.0 }
    let emptyColumns = (0 ..< lines.count).filter { index in lines.allSatisfy { line in line[line.index(line.startIndex, offsetBy: index)] == "." } }
    var galaxies: Set<Point> = []
    var expandYBy = 0
    for (y, line) in lines.enumerated() {
      var expandXBy = 0
      if emptyRows.contains(y) {
        expandYBy += expandBy
        continue
      }
      for (x, point) in line.enumerated() {
        if emptyColumns.contains(x) {
          expandXBy += expandBy
        }
        if point == "#" {
          galaxies.insert(Point(x: x + expandXBy, y: y + expandYBy))
        }
      }
    }
    return galaxies
  }
}
