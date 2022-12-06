// Created by Daniele Formichelli.

import Foundation
import Utils

/// https://adventofcode.com/2022/day/6
struct Year2022Day6: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    return self.findMarker(ofLength: 4, in: input)
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    return self.findMarker(ofLength: 14, in: input)
  }

  func findMarker(ofLength count: Int, in input: String) -> Int {
    var window: [Character] = []
    for (index, character) in input.enumerated() {
      window.append(character)
      if index < count - 1 {
        continue
      } else if window.asSet.count == count {
        return index + 1
      } else {
        window.remove(at: 0)
      }
    }
    fatalError("marker not found")
  }
}
