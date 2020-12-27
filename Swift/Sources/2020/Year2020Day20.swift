//
//  Year2020Day20.swift
//  AdventOfCode2020
//
//  Created by Daniele Formichelli on 20/12/2020.
//  Copyright © 2020 Daniele Formichelli. All rights reserved.
//

import Foundation
import Utils

/// https://adventofcode.com/2020/day/20
public struct Year2020Day20: DayBase {
  public func part1(_ input: String) -> CustomDebugStringConvertible {
    let classified = input.tiles.classify()
    return classified[.corner]!.reduce(1) { result, tile in result * tile.id }
  }

  public func part2(_ input: String) -> CustomDebugStringConvertible {
    let tiles = input.tiles
    let size = Int(sqrt(Double(tiles.count)))
    let tileSize = tiles.first!.value.content.count
    let imageTiles = self.getImage(tiles: tiles)

    let imageSize = size * (tileSize - 2)
    var content: [String] = []
    for row in 0 ..< size {
      for innerRow in 1 ..< tileSize - 1 {
        var line = ""
        for column in 0 ..< size {
          let tile = imageTiles[Point(x: column, y: row)]!
          line += tile.content[innerRow].dropFirst().dropLast()
        }
        content.append(line)
      }
    }

    let seaMonster = [
      Point(x: 18, y: 0),
      Point(x: 0, y: 1),
      Point(x: 5, y: 1),
      Point(x: 6, y: 1),
      Point(x: 11, y: 1),
      Point(x: 12, y: 1),
      Point(x: 17, y: 1),
      Point(x: 18, y: 1),
      Point(x: 19, y: 1),
      Point(x: 1, y: 2),
      Point(x: 4, y: 2),
      Point(x: 7, y: 2),
      Point(x: 10, y: 2),
      Point(x: 13, y: 2),
      Point(x: 16, y: 2)
    ]
    let seaMonsterWidth = seaMonster.max { $0.x < $1.x }!.x + 1
    let seaMonsterHeight = seaMonster.max { $0.y < $1.y}!.y + 1

    for orientation in content.allOrientations {
      var seaMonstersCount = 0
      for row in 0 ..< imageSize - 1 - seaMonsterHeight {
        for column in 0 ..< imageSize - 1 - seaMonsterWidth {
          var matched = true
          for seaMonsterPoint in seaMonster {
            let row = row + seaMonsterPoint.y
            let column = column + seaMonsterPoint.x
            let line = orientation[row]
            let element = line[line.index(line.startIndex, offsetBy: column )]
            guard element == "#" else {
              matched = false
              break
            }
          }
          if matched {
            seaMonstersCount += 1
          }
        }
      }

      if seaMonstersCount != 0 {
        return content.map { $0.filter { $0 == "#" }.count }.sum - seaMonstersCount * seaMonster.count
      }
    }

    fatalError()
  }

  private func getImage(tiles: [Int: Year2020Day20.Tile]) -> [Point: Tile] {
    let size = Int(sqrt(Double(tiles.count)))
    let classified = tiles.classify()
    var image: [Point: Tile] = [:]
    let corners = classified[.corner]!
    for corner in corners {
      var remaining = classified
      remaining[.corner]?.remove(corner)
      for orientation in corner.allOrientations {
        image[.zero] = orientation
        if self.fill(&image, ofSize: size, classified: remaining, current: Point(x: 1, y: 0)) {
          return image
        }
      }
    }
    fatalError()
  }

  private func fill(
    _ image: inout [Point: Tile],
    ofSize size: Int,
    classified: [TileType: Set<Tile>],
    current: Point
  ) -> Bool {
    guard current.y < size else {
      return true
    }

    let type: TileType
    switch (current.x, current.y) {
    case (0, 0), (0, size - 1), (size - 1, 0), (size - 1, size - 1):
      type = .corner
    case (0, _), (_, 0), (size - 1, _), (_, size - 1):
      type = .edge
    default:
      type = .middle
    }

    let availableTiles = classified[type]!
    let above = Point(x: current.x, y: current.y - 1)
    let before = Point(x: current.x - 1, y: current.y)
    for tile in availableTiles {
      var oriented: Tile?

      if current.y > 0 {
        oriented = tile.oriented(direction: .up, border: image[above]!.borders[.down]!)
        if oriented == nil {
          continue
        }
      }

      if current.x > 0 {
        let newOriented = tile.oriented(direction: .left, border: image[before]!.borders[.right]!)
        if newOriented == nil {
          continue
        }
        if oriented != nil && newOriented != oriented {
          continue
        }
        oriented = newOriented
      }

      image[current] = oriented
      var remaining = classified
      remaining[type]?.remove(tile)
      if self.fill(
        &image,
        ofSize: size,
        classified: remaining,
        current: Point(
          x: current.x < size - 1 ? current.x + 1 : 0,
          y: current.x < size - 1 ? current.y : current.y + 1
        )
      ) {
        return true
      }
    }

    return false
  }
}

extension Year2020Day20 {
  fileprivate struct LeftAndTop: Hashable {
    let left: Int
    let top: Int
  }

  fileprivate struct Image: Hashable {
    let size: Int
    let content: Set<Point>
  }

  fileprivate enum TileType: Hashable {
    case corner
    case edge
    case middle
  }

  fileprivate struct Tile: Hashable {
    let id: Int
    let content: [String]

    subscript(_ point: Point) -> Character {
      let row = self.content[point.y]
      let element = row[row.index(row.startIndex, offsetBy: point.x)]
      return element
    }

    var borders: [Direction: Int] {
      return [
        .up: self.content.first!.asArray.int,
        .down: self.content.last!.asArray.int,
        .left: self.content.map { $0.first! }.int,
        .right: self.content.map { $0.last! }.int
      ]
    }

    var allBorders: Set<Int> {
      return self.borders.values.asSet.union(self.borders.values.map(\.flipped).asSet)
    }

    var allOrientations: Set<Tile> {
      return self.content.allOrientations.map { .init(id: self.id, content: $0) }.asSet
    }

    func oriented(direction: Direction, border: Int) -> Tile? {
      return self.allOrientations.first { $0.borders[direction] == border }
    }
  }
}

extension Set where Element == Year2020Day20.Tile {
//  func classify(allPossibleBorders: Set<Int>) -> [Int: TileType] {
//    return Dictionary(uniqueKeysWithValues: self.map { ($0.id, $0.classify(allPossibleBorders: allPossibleBorders)) })
//  }
}

extension Int {
  var flipped: Int {
    var flipped = 0
    for i in 0 ..< 10 where self & 1 << i != 0 {
      flipped |= 1 << (9 - i)
    }
    return flipped
  }
}

extension String {
  fileprivate var tiles: [Int: Year2020Day20.Tile] {
    return Dictionary(uniqueKeysWithValues: self
      .components(separatedBy: "\n\n")
      .map { tile in
        let idAndContent = tile.dropFirst(5).components(separatedBy: ":\n")
        let id = Int(idAndContent[0])!
        let content = idAndContent[1].split(separator: "\n").map(String.init)
        let tile = Year2020Day20.Tile(
          id: id,
          content: content
        )
        return tile
      }
      .map { ($0.id, $0) }
    )
  }
}

extension Array where Element == Character {
  var int: Int {
    return self
      .reversed()
      .enumerated()
      .filter { _, character in character == "#" }
      .map { index, _ in 1 << index }
      .sum
  }
}

extension Array where Element == String {
  var rotated: Self {
    (0 ..< self.count).map { i in
      var line = ""
      for j in 0 ..< self.count {
        let row = self[self.count - j - 1]
        let element = row[row.index(row.startIndex, offsetBy: i)]
        line.append(element)
      }
      return line
    }
  }

  var flippedVertically: Self {
    (0 ..< self.count).map { i in
      return self[self.count - i - 1]
    }
  }

  var flippedHorizontally: Self {
    return self.map { line in
      return String(line.reversed())
    }
  }

  var allOrientations: Set<[String]> {
    var orientations: Set<[String]> = []
    var content = self
    (1 ... 4).forEach { _ in
      content = content.rotated
      orientations.insert(content)
      orientations.insert(content.flippedVertically)
      orientations.insert(content.flippedHorizontally)
    }
    return orientations
  }
}

extension Dictionary where Key == Int, Value == Year2020Day20.Tile {
  func classify() -> [Year2020Day20.TileType: Set<Year2020Day20.Tile>] {
    var borderToTiles: [Int: Set<Int>] = [:]
    for tile in self.values {
      for border in tile.allBorders {
        var currentTiles = borderToTiles[border] ?? []
        currentTiles.insert(tile.id)
        borderToTiles[border] = currentTiles
      }
    }

    var typeToTiles: [Year2020Day20.TileType: Set<Year2020Day20.Tile>] = [:]
    self.values.forEach { tile in
      // divide by two because it matches both flipped and not flipped
      let matches = tile.allBorders.filter { borderToTiles[$0]?.count ?? 0 > 1 }.count / 2
      let type: Year2020Day20.TileType
      switch matches {
      case 2:
        type = .corner
      case 3:
        type = .edge
      case 4:
        type = .middle
      default:
        fatalError()
      }
      var current = typeToTiles[type] ?? []
      current.insert(tile)
      typeToTiles[type] = current
    }

    return typeToTiles
  }
}
