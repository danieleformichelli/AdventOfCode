// Created by Daniele Formichelli.

import Parsing
import Utils

/// https://adventofcode.com/2015/day/4
struct Year2015Day4: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    return Self.md5Prefix(secret: input, prefix: "00000")
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    return Self.md5Prefix(secret: input, prefix: "000000")
  }

  private static func md5Prefix(secret: String, prefix: String) -> Int {
    var i = 0
    while true {
      let md5 = (secret + String(i)).md5
      guard !md5.starts(with: prefix) else {
        return i
      }
      i += 1
    }
    return i
  }
}

extension String {
  private var directions: [Direction] {
    let direction = StartsWith<Substring>("^").map { Direction.up }
      .orElse(StartsWith("v").map { Direction.down })
      .orElse(StartsWith(">").map { Direction.right })
      .orElse(StartsWith("<").map { Direction.left })
    return Many(direction).parse(self)!
  }
}
