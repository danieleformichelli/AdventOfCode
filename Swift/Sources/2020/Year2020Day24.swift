//
//  Year2020Day24.swift
//  AdventOfCode2020
//
//  Created by Daniele Formichelli on 24/12/2020.
//  Copyright © 2020 Daniele Formichelli. All rights reserved.
//

import Foundation
import Utils

/// https://adventofcode.com/2020/day/24
public struct Year2020Day24: DayBase {
  public func part1(_ input: String) -> CustomDebugStringConvertible {
    return input.blackTiles.count
  }

  public func part2(_ input: String) -> CustomDebugStringConvertible {
    var black: Set<Point> = input.blackTiles
    (1 ... 100).forEach { _ in
      var blackToWhite: Set<Point> = []
      var whiteBlackAdjacents: [Point: Int] = [:]
      black.forEach { tile in
        var blackAdjacents = 0
        for adjacent in tile.adjacentTiles {
          if black.contains(adjacent) {
            blackAdjacents += 1
          } else {
            whiteBlackAdjacents[adjacent] = (whiteBlackAdjacents[adjacent] ?? 0) + 1
          }
        }

        if blackAdjacents == 0 || blackAdjacents > 2 {
          blackToWhite.insert(tile)
        }
      }

      let whiteToBlack = whiteBlackAdjacents.filter { $0.value == 2}.keys
      black.formSymmetricDifference(blackToWhite)
      black.formSymmetricDifference(whiteToBlack)
    }
    return black.count
  }
}

extension Point {
  var adjacentTiles: Set<Point> {
    return [
      .init(x: self.x - 1, y: self.y + 1),
      .init(x: self.x + 1, y: self.y + 1),
      .init(x: self.x - 1, y: self.y - 1),
      .init(x: self.x + 1, y: self.y - 1),
      .init(x: self.x - 2, y: self.y),
      .init(x: self.x + 2, y: self.y)
    ]
  }
}

extension String {
  fileprivate var blackTiles: Set<Point> {
    let directions: [[Direction]] = self.lines.map { line in
      var directions: [Direction] = []
      var index = 0
      while index < line.count {
        switch line[line.index(line.startIndex, offsetBy: index)] {
        case "n":
          directions.append(.up)
          let direction: Direction = line[line.index(line.startIndex, offsetBy: index + 1)] == "e" ? .right : .left
          directions.append(direction)
          index += 2
        case "s":
          directions.append(.down)
          let direction: Direction = line[line.index(line.startIndex, offsetBy: index + 1)] == "e" ? .right : .left
          directions.append(direction)
          index += 2
        case "e":
          directions.append(.right)
          directions.append(.right)
          index += 1
        case "w":
          directions.append(.left)
          directions.append(.left)
          index += 1
        default:
          fatalError()
        }
      }
      return directions
    }

    var black: Set<Point> = []
    for tileToFlip in directions {
      let point = tileToFlip.reduce(Point(x: 0, y: 0)) { result, direction in
        return .init(x: result.x + direction.dx, y: result.y + direction.dy)
      }
      black.formSymmetricDifference([point])
    }
    return black
  }
}
