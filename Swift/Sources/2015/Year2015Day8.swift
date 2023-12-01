// Created by Daniele Formichelli.

import Utils

/// https://adventofcode.com/2015/day/8
struct Year2015Day8: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    return input.lines
      .map { line in return line.count - line.decoded.count }
      .sum
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    return input.lines
      .map { line in return line.encoded.count - line.count }
      .sum
  }
}

extension String {
  fileprivate var encoded: String {
    let encoded = self
      .replacingOccurrences(of: "\\", with: "\\\\")
      .replacingOccurrences(of: "\"", with: "\\\"")
    return "\"\(encoded)\""
  }

  fileprivate var decoded: String {
    var decoded = self
      .dropFirst()
      .dropLast()
      .replacingOccurrences(of: "\\\\", with: "/")
      .replacingOccurrences(of: "\\\"", with: "\"")

    while true {
      guard let nextHex = decoded.range(of: "\\x") else {
        return decoded
      }

      let hex = decoded[decoded.index(nextHex.lowerBound, offsetBy: 2) ... decoded.index(nextHex.lowerBound, offsetBy: 3)]
      let dec = Int(String(hex), radix: 16)!
      let char = String(Character(UnicodeScalar(dec)!))
      decoded.replaceSubrange(nextHex.lowerBound ... decoded.index(nextHex.lowerBound, offsetBy: 3), with: char)
    }

    return decoded.replacingOccurrences(of: "/", with: "\\")
  }
}
