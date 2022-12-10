// Created by Daniele Formichelli.

import Foundation
import Utils

/// https://adventofcode.com/2022/day/8
struct Year2022Day8: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    let treeHeights = input.treeHeights
    var visibleTrees = Set<Point>()
    let rows = treeHeights.count
    let cols = treeHeights[0].count
    for row in 0 ..< rows {
      var maxHeightInRow = -1
      for col in 0 ..< cols {
        let treeHeight = treeHeights[row][col]
        if treeHeight > maxHeightInRow {
          visibleTrees.insert(Point(x: row, y: col))
          maxHeightInRow = treeHeight
        }
      }
    }
    for row in 0 ..< rows {
      var maxHeightInRow = -1
      for col in stride(from: cols - 1, to: 0, by: -1) {
        let treeHeight = treeHeights[row][col]
        if treeHeight > maxHeightInRow {
          visibleTrees.insert(Point(x: row, y: col))
          maxHeightInRow = treeHeight
        }
      }
    }
    for col in 0 ..< cols {
      var maxHeightInCol = -1
      for row in 0 ..< rows {
        let treeHeight = treeHeights[row][col]
        if treeHeight > maxHeightInCol {
          visibleTrees.insert(Point(x: row, y: col))
          maxHeightInCol = treeHeight
        }
      }
    }
    for col in 0 ..< cols {
      var maxHeightInCol = -1
      for row in stride(from: rows - 1, to: 0, by: -1) {
        let treeHeight = treeHeights[row][col]
        if treeHeight > maxHeightInCol {
          visibleTrees.insert(Point(x: row, y: col))
          maxHeightInCol = treeHeight
        }
      }
    }

    return visibleTrees.count
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    let treeHeights = input.treeHeights
    var highestScore = 0
    let rows = treeHeights.count
    let cols = treeHeights[0].count
    for row in 0 ..< rows {
      for col in 0 ..< cols {
        let treeHeight = treeHeights[row][col]
        var upCount = 0
        while row - upCount - 1 >= 0 {
          upCount += 1
          if treeHeights[row - upCount][col] >= treeHeight {
            break
          }
        }
        var downCount = 0
        while row + downCount + 1 < rows {
          downCount += 1
          if treeHeights[row + downCount][col] >= treeHeight {
            break
          }
        }
        var leftCount = 0
        while col - leftCount - 1 >= 0 {
          leftCount += 1
          if treeHeights[row][col - leftCount] >= treeHeight {
            break
          }
        }
        var rightCount = 0
        while col + rightCount + 1 < cols {
          rightCount += 1
          if treeHeights[row][col + rightCount] >= treeHeight {
            break
          }
        }
        highestScore = max(highestScore, upCount * downCount * leftCount * rightCount)
      }
    }

    return highestScore
  }
}

extension String {
  var treeHeights: [[Int]] {
    return self.lines.map { $0.compactMap { Int(String($0)) } }
  }
}
