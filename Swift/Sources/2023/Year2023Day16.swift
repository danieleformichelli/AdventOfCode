// Created by Daniele Formichelli.

import Utils

/// https://adventofcode.com/2023/day/16
struct Year2023Day16: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    return Self.solve(grid: input.grid, from: Point(x: 0, y: 0), direction: .right)
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    let grid = input.grid
    var maxX = 0
    var maxY = 0
    for element in grid.keys {
      maxX = max(element.x, maxX)
      maxY = max(element.y, maxY)
    }
    var result = 0
    for x in 0 ... maxX {
      result = max(result, Self.solve(grid: grid, from: Point(x: x, y: 0), direction: .down))
      result = max(result, Self.solve(grid: grid, from: Point(x: x, y: maxY), direction: .up))
    }
    for y in 0 ... maxY {
      result = max(result, Self.solve(grid: grid, from: Point(x: 0, y: y), direction: .right))
      result = max(result, Self.solve(grid: grid, from: Point(x: maxX, y: y), direction: .left))
    }
    return result
  }
  
  static func solve(grid: [Point: GridElement], from point: Point, direction: Direction) -> Int {
    var energized: Set<Point> = []
    var visited: Set<Visited> = []
    Self.followBeam(from: point, direction: direction, grid: grid, energized: &energized, visited: &visited)
    return energized.count
  }
  
  static func followBeam(from point: Point, direction: Direction, grid: [Point: GridElement], energized: inout Set<Point>, visited: inout Set<Visited>) {
    if !visited.insert(Visited(point: point, direction: direction)).inserted {
      return
    }
    guard let element = grid[point] else {
      return
    }
    energized.insert(point)
    switch element {
    case .empty,
         .verticalSplitter where direction.dx == 0,
         .horizontalSplitter where direction.dy == 0:
      followBeam(from: Point(x: point.x + direction.dx, y: point.y - direction.dy), direction: direction, grid: grid, energized: &energized, visited: &visited)
    case .leftMirror:
      var newDirection: Direction
      switch direction {
      case .up:
        newDirection = .left
      case .down:
        newDirection = .right
      case .right:
        newDirection = .down
      case .left:
        newDirection = .up
      }
      followBeam(from: Point(x: point.x + newDirection.dx, y: point.y - newDirection.dy), direction: newDirection, grid: grid, energized: &energized, visited: &visited)
    case .rightMirror:
      var newDirection: Direction
      switch direction {
      case .up:
        newDirection = .right
      case .down:
        newDirection = .left
      case .right:
        newDirection = .up
      case .left:
        newDirection = .down
      }
      followBeam(from: Point(x: point.x + newDirection.dx, y: point.y - newDirection.dy), direction: newDirection, grid: grid, energized: &energized, visited: &visited)
    case .verticalSplitter:
      followBeam(from: Point(x: point.x, y: point.y - Direction.up.dy), direction: .up, grid: grid, energized: &energized, visited: &visited)
      followBeam(from: Point(x: point.x, y: point.y - Direction.down.dy), direction: .down, grid: grid, energized: &energized, visited: &visited)
    case .horizontalSplitter:
      followBeam(from: Point(x: point.x + Direction.left.dx, y: point.y), direction: .left, grid: grid, energized: &energized, visited: &visited)
      followBeam(from: Point(x: point.x + Direction.right.dx, y: point.y), direction: .right, grid: grid, energized: &energized, visited: &visited)
    }
  }
}

struct Visited: Hashable {
  let point: Point
  let direction: Direction
}

enum GridElement {
  case empty
  case leftMirror
  case rightMirror
  case verticalSplitter
  case horizontalSplitter
}

extension String {
  fileprivate var grid: [Point: GridElement] {
    var map: [Point: GridElement] = [:]
    for (y, line) in self.lines.enumerated() {
      for (x, char) in line.enumerated() {
        let point = Point(x: x, y: y)
        switch char {
        case ".":
          map[point] = .empty
        case "\\":
          map[point] = .leftMirror
        case "/":
          map[point] = .rightMirror
        case "|":
          map[point] = .verticalSplitter
        case "-":
          map[point] = .horizontalSplitter
        default:
          break
        }
      }
    }
    return map
  }
}
