// Created by Daniele Formichelli.

import Utils

/// https://adventofcode.com/2020/day/10
public struct Year2020Day10: DayBase {
  public func part1(_ input: String) -> CustomDebugStringConvertible {
    var oneJoltDifferences = 0
    var threeJoltDifferences = 1
    let adaptersJolts = ([0] + input.numbers).sorted()
    for (index, adapterJolts) in adaptersJolts.enumerated().dropFirst() {
      switch adapterJolts - adaptersJolts[index - 1] {
      case 1:
        oneJoltDifferences += 1
      case 3:
        threeJoltDifferences += 1
      default:
        break
      }
    }

    return oneJoltDifferences * threeJoltDifferences
  }

  public func part2(_ input: String) -> CustomDebugStringConvertible {
    var cache: [Int: Int] = [:]
    return self.countArrangements(in: ([0] + input.numbers).sorted(), cache: &cache)
  }

  private func countArrangements(for index: Int = 0, in adaptersJolts: [Int], cache: inout [Int: Int]) -> Int {
    if let cached = cache[index] {
      return cached
    }

    guard index < adaptersJolts.count - 1 else {
      return 1
    }

    var count = 0
    var j = index + 1
    while j < adaptersJolts.count, adaptersJolts[j] <= adaptersJolts[index] + 3 {
      count += self.countArrangements(for: j, in: adaptersJolts, cache: &cache)
      j += 1
    }
    count = max(1, count)
    cache[index] = count
    return count
  }
}

extension String {
  fileprivate var adaptersJolts: [Int] {
    return ([0] + self.numbers).sorted()
  }
}
