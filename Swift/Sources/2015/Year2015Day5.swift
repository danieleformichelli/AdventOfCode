// Created by Daniele Formichelli.

import Utils

/// https://adventofcode.com/2015/day/5
struct Year2015Day5: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    return input.lines
      .filter { line in
        let vowels: Set<Character> = ["a", "e", "i", "o", "u"]
        guard line.filter({ vowels.contains($0) }).count >= 3 else {
          return false
        }

        for bad in ["ab", "cd", "pq", "xy"] {
          guard !line.contains(bad) else {
            return false
          }
        }

        var currentIndex = line.index(after: line.startIndex)
        while currentIndex != line.endIndex {
          if line[currentIndex] == line[line.index(before: currentIndex)] {
            return true
          }
          currentIndex = line.index(after: currentIndex)
        }

        return false
      }
      .count
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    return input.lines
      .filter { line in
        var pairs: [String: Set<Int>] = [:]
        for i in 0 ..< line.count - 1 {
          let startIndex = line.index(line.startIndex, offsetBy: i)
          let endIndex = line.index(line.startIndex, offsetBy: i + 1)
          let pair = String(line[startIndex ... endIndex])
          pairs[pair] = (pairs[pair] ?? []).union([i])
        }

        guard !pairs.filter({ $0.value.max()! - $0.value.min()! > 1 }).isEmpty else {
          return false
        }

        var currentIndex = line.index(line.startIndex, offsetBy: 2)
        while currentIndex != line.endIndex {
          if line[currentIndex] == line[line.index(currentIndex, offsetBy: -2)] {
            break
          }
          currentIndex = line.index(after: currentIndex)
        }

        return currentIndex != line.endIndex
      }
      .count
  }
}
