// Created by Daniele Formichelli.

import Utils

/// https://adventofcode.com/2023/day/17
struct Year2023Day17: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    return Self.solve(input: input, minBeforeTurn: 0, maxBeforeTurn: 3)
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    return Self.solve(input: input, minBeforeTurn: 4, maxBeforeTurn: 10)
  }
  
  static func solve(input: String, minBeforeTurn: Int, maxBeforeTurn: Int) -> Int {
    let heatMap = input.heatMap
    var maxX = 0
    var maxY = 0
    for element in heatMap.keys {
      maxX = max(element.x, maxX)
      maxY = max(element.y, maxY)
    }
    var visited: Set<VisitedKey> = [];
    let target = Point(x: maxX, y: maxY)
    var queue = [Path(point: Point(x: 0, y: 0), heatLoss: 0, direction: .right, movesInDirection: 0)]
    while let element = queue.first {
      if element.point == target {
        return element.heatLoss
      }
      
      queue.removeFirst()
      if !visited.insert(VisitedKey(point: element.point, direction: element.direction, movesInDirection: element.movesInDirection)).inserted {
        continue
      }
      
      var newPointsAndDirections: [(Point, Direction, Int)] = []
      if element.movesInDirection >= minBeforeTurn {
        newPointsAndDirections.append((Point(x: element.point.x + element.direction.turnRight.dx, y: element.point.y -  element.direction.turnRight.dy), element.direction.turnRight, 1))
        newPointsAndDirections.append((Point(x: element.point.x + element.direction.turnLeft.dx, y: element.point.y - element.direction.turnLeft.dy), element.direction.turnLeft, 1))
      }
      if element.movesInDirection < maxBeforeTurn {
        newPointsAndDirections.append((Point(x: element.point.x + element.direction.dx, y: element.point.y - element.direction.dy), element.direction, element.movesInDirection + 1))
      }
      
      for newPointAndDirection in newPointsAndDirections {
        guard let nextHeatLoss = heatMap[newPointAndDirection.0] else { continue }
        let newHeatLoss = element.heatLoss + nextHeatLoss
        let insertionIndex = queue.firstIndex { $0.heatLoss > newHeatLoss }
        let nextElement = Path(point: newPointAndDirection.0, heatLoss: newHeatLoss, direction: newPointAndDirection.1, movesInDirection: newPointAndDirection.2)
        queue.insert(nextElement, at: insertionIndex ?? queue.endIndex)
      }
    }
    fatalError()
  }
}

struct VisitedKey: Hashable {
  let point: Point
  let direction: Direction
  let movesInDirection: Int
}

struct Path: Hashable {
  let point: Point
  let heatLoss: Int
  let direction: Direction
  let movesInDirection: Int
}

extension String {
  fileprivate var heatMap: [Point: Int] {
    var map: [Point: Int] = [:]
    for (y, line) in self.lines.enumerated().dropFirst(0) {
      for (x, heatLoss) in line.enumerated().dropFirst(0) {
        map[Point(x: x, y: y)] = Int(String(heatLoss))!
      }
    }
    return map
  }
}
