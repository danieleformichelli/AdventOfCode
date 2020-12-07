//
//  Year2020Day5.swift
//  AdventOfCode2020
//
//  Created by Daniele Formichelli on 05/12/2020.
//  Copyright © 2020 Daniele Formichelli. All rights reserved.
//

import Utils

/// https://adventofcode.com/2020/day/5
public struct Year2020Day5: DayBase {
  let rows = 128
  let columns = 8

  public func part1(_ input: String) -> CustomDebugStringConvertible {
    self.bookedSeatIDs(input).max()!
  }

  public func part2(_ input: String) -> CustomDebugStringConvertible {
    let lastID = (rows - 1) * self.columns + self.columns - 1
    let allIDs = Set(0 ... lastID)
    let bookedSeatIDs = self.bookedSeatIDs(input)
    return allIDs
      .first { !bookedSeatIDs.contains($0) && bookedSeatIDs.contains($0 - 1) && bookedSeatIDs.contains($0 + 1) }!
  }

  private func bookedSeatIDs(_ input: String) -> Set<Int> {
    Set(
      input.lines
        .map { seat -> Int in
          var minRow = 0
          var maxRow = self.rows - 1
          for rowPartition in seat.rowPartitions {
            let midRow = (minRow + maxRow) / 2
            switch rowPartition {
            case .front:
              maxRow = midRow
            case .back:
              minRow = midRow + 1
            }
          }

          guard minRow == maxRow else { fatalError() }

          var minCol = 0
          var maxCol = self.columns - 1
          for columnPartition in seat.columnPartitions {
            let midCol = (minCol + maxCol) / 2
            switch columnPartition {
            case .left:
              maxCol = midCol
            case .right:
              minCol = midCol + 1
            }
          }

          guard minCol == maxCol else { fatalError() }

          return minRow * self.columns + minCol
        }
    )
  }
}

private extension Year2020Day5 {
  enum RowPartition: String {
    case front = "F"
    case back = "B"
  }

  enum ColumnPartition: String {
    case left = "L"
    case right = "R"
  }
}

private extension String {
  var rowPartitions: [Year2020Day5.RowPartition] {
    compactMap { Year2020Day5.RowPartition(rawValue: String($0)) }
  }

  var columnPartitions: [Year2020Day5.ColumnPartition] {
    compactMap { Year2020Day5.ColumnPartition(rawValue: String($0)) }
  }
}
