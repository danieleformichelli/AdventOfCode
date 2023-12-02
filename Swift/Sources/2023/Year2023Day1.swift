// Created by Daniele Formichelli.

import Utils

/// https://adventofcode.com/2023/day/1
struct Year2023Day1: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    return input.digits(includeWords: false).sum
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    return input.digits(includeWords: true).sum
  }
}

extension String {
  func digits(includeWords: Bool) -> [Int] {
    return self.lines.map { line in
      var first: Int? = nil
      var last: Int? = nil
      for (index, char) in line.enumerated() {
        var digit: Int? = nil
        if let parsedInt = Int(String(char)) {
          digit = parsedInt
        } else if includeWords {
          for (digitIndex, stringDigit) in ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"].enumerated() {
            if line[line.index(line.startIndex, offsetBy: index)...].starts(with: stringDigit) {
              digit = digitIndex + 1
            }
          }
        }
          
        if let digit {
          if first == nil {
            first = digit
          }
          last = digit
        }
      }
      return first! * 10 + last!
    }
  }
}
