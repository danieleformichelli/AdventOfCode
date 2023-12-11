// Created by Daniele Formichelli.

import Utils

/// https://adventofcode.com/2023/day/10
struct Year2023Day10: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    let tiles = input.tiles
    let from = tiles.first { $0.value == .START }!.key
    return Self.loop(from: from, tiles: tiles).count / 2
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    let tiles = input.tiles
    let from = tiles.first { $0.value == .START }!.key
    let loop = Self.loop(from: from, tiles: tiles)
    var minX: Int = Int.max
    var maxX: Int = Int.min
    var minY: Int = Int.max
    var maxY: Int = Int.min
    for tile in loop {
      minX = min(minX, tile.x)
      maxX = max(maxX, tile.x)
      minY = min(minY, tile.y)
      maxY = max(maxY, tile.y)
    }
    var inside: Set<Point> = []
    for y in minY ..< maxY {
      var comingFromNorth: Bool? = nil
      var walls = 0
      for x in minX ..< maxX {
        let point = Point(x: x, y: y)
        if loop.contains(point) {
          switch tiles[point] {
          case .START:
            // for the specific input, start is a NS
            walls += 1
          case .NS:
            walls += 1
          case .NW, .NE:
            if let unwrappedComingFromNorth = comingFromNorth {
              comingFromNorth = nil
            } else {
              comingFromNorth = true
            }
          case .SW, .SE:
            if let unwrappedComingFromNorth = comingFromNorth {
              if unwrappedComingFromNorth {
                walls += 1
              }
              comingFromNorth = nil
            } else {
              comingFromNorth = false
            }
          case .WE, .EMPTY, .none:
            break
          }
        } else {
          if walls % 2 == 1 {
            inside.insert(point)
          }
        }
      }
    }
    for x in minX ..< maxX {
      var comingFromWest: Bool? = nil
      var walls = 0
      for y in minY ..< maxY {
        let point = Point(x: x, y: y)
        if loop.contains(point) {
          switch tiles[point] {
          case .START:
            // for the specific input, start is a NS
            break
          case .WE:
            walls += 1
          case .NW, .SW:
            if let unwrappedComingFromWest = comingFromWest {
              comingFromWest = nil
            } else {
              comingFromWest = true
            }
          case .NE, .SE:
            if let unwrappedComingFromWest = comingFromWest {
              if unwrappedComingFromWest {
                walls += 1
              }
              comingFromWest = nil
            } else {
              comingFromWest = false
            }
          case .NS, .EMPTY, .none:
            break
          }
        } else {
          if walls % 2 == 0 {
            inside.remove(point)
          }
        }
      }
    }
    return inside.count
  }
  
  static func loop(from: Point, tiles: [Point: Tile]) -> [Point] {
    var toExplore = Tile.START.connectsTo(from: from).map { (from: $0, loop: [from]) }
    while let last = toExplore.last {
      for next in tiles[last.from]?.connectsTo(from: last.from) ?? [] {
        if next == last.loop.last {
          continue
        }
        if next == from {
          return last.loop + [last.from]
        }
        if tiles[next]?.connectsTo(from: next).contains(last.from) ?? false {
          toExplore.append((from: next, loop: last.loop + [last.from]))
        }
      }
    }
    fatalError()
  }
}

enum Tile: String {
  case START = "S"
  case NW = "J"
  case NE = "L"
  case NS = "|"
  case WE = "-"
  case SW = "7"
  case SE = "F"
  case EMPTY = "."
  
  func connectsTo(from point: Point) -> Set<Point> {
    switch self {
    case .START:
      return [Point(x: point.x, y: point.y - 1), Point(x: point.x, y: point.y + 1), Point(x: point.x - 1, y: point.y), Point(x: point.x + 1, y: point.y)]
    case .NW:
      return [Point(x: point.x, y: point.y - 1), Point(x: point.x - 1, y: point.y)]
    case .NE:
      return [Point(x: point.x, y: point.y - 1), Point(x: point.x + 1, y: point.y)]
    case .NS:
      return [Point(x: point.x, y: point.y - 1), Point(x: point.x, y: point.y + 1)]
    case .WE:
      return [Point(x: point.x - 1, y: point.y), Point(x: point.x + 1, y: point.y)]
    case .SW:
      return [Point(x: point.x, y: point.y + 1), Point(x: point.x - 1, y: point.y)]
    case .SE:
      return [Point(x: point.x, y: point.y + 1), Point(x: point.x + 1, y: point.y)]
    case .EMPTY:
      return []
    }
  }
}

extension String {
  fileprivate var tiles: [Point: Tile] {
    var tiles: [Point: Tile] = [:]
    self.lines.enumerated().forEach { y, line in
      line.enumerated().forEach { x, tileStr in
        guard let tile = Tile(rawValue: String(tileStr)) else {
          fatalError()
        }
        tiles[Point(x: x, y: y)] = tile
      }
    }
    return tiles
  }
}
