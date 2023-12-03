// Created by Daniele Formichelli.

import Utils

/// https://adventofcode.com/2023/day/3
struct Year2023Day3: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    let schematic = input.schematic
    return schematic.numberToPoints.map { number, pointsSets in
      return pointsSets.map { pointsSet in
        for point in pointsSet {
          for dx in [-1, 0 , 1] {
            for dy in [-1, 0, 1] {
              if schematic.symbols.contains(Point(x: point.x + dx, y: point.y + dy)) {
                return number
              }
            }
          }
        }
        return 0
      }.sum
    }.sum as Int
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    let schematic = input.schematic
    return schematic.asterisks.map { point in
      var adjacentNumbers: Set<Int> = []
      for dx in [-1, 0 , 1] {
        for dy in [-1, 0, 1] {
          if let number = schematic.pointToNumber[Point(x: point.x + dx, y: point.y + dy)] {
            // This doesn't take into account the case in which the adjacent numbers are the same number, but it doesn't seem to be a problem
            adjacentNumbers.insert(number)
          }
        }
      }
      if adjacentNumbers.count == 2 {
        return adjacentNumbers.multiply
      } else {
        return 0
      }
    }.sum as Int
  }
}

struct Schematic {
  let pointToNumber: [Point: Int]
  let numberToPoints: [Int: [[Point]]]
  let asterisks: Set<Point>
  let symbols: Set<Point>
}

extension String {
  fileprivate var schematic: Schematic {
    var pointToNumber: [Point: Int] = [:]
    var numberToPoints: [Int: [[Point]]] = [:]
    var asterisks: Set<Point> = []
    var symbols: Set<Point> = []
    self.lines.enumerated().forEach { row, line in
      var numberStartColumn: Int?
      (line + ".").enumerated().forEach { column, char in
        if char.isNumber {
          if (numberStartColumn == nil) {
            numberStartColumn = column
          }
        } else {
          if let startColumn = numberStartColumn {
            let numberString = line[line.index(line.startIndex, offsetBy: startColumn)..<line.index(line.startIndex, offsetBy: column)]
            let number = Int(numberString)!
            let points = (startColumn..<column).map {
              let point = Point(x: $0, y: row)
              pointToNumber[point] = number
              return point
            }
            if numberToPoints[number] == nil {
              numberToPoints[number] = []
            }
            numberToPoints[number]?.append(points)
            
            numberStartColumn = nil
          }
          if char != "." {
            symbols.insert(Point(x: column, y: row))
            if char == "*" {
              asterisks.insert(Point(x: column, y: row))
            }
          }
        }
      }
    }
    return Schematic(pointToNumber: pointToNumber, numberToPoints: numberToPoints, asterisks: asterisks, symbols: symbols)
  }
}
