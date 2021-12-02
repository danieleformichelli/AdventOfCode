// Created by Daniele Formichelli.

import Utils

/// https://adventofcode.com/2019/day/16
struct Year2019Day16: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    let basePattern = [0, 1, 0, -1]
    let numbers = input.numbers
    var signal = numbers
    for _ in 1 ... 100 {
      signal = (1 ... numbers.count).map { position in
        let sum = signal.enumerated()
          .map { index, number -> Int in
            let multiplierIndex = ((index + 1) / position) % basePattern.count
            return number * basePattern[multiplierIndex]
          }
          .sum
        return abs(sum) % 10
      }
    }
    return signal.dropLast(signal.count - 8).map { String($0) }.joined(separator: "")
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    let signal = Array((1 ... 10000).map { _ in input.numbers }.joined())
    let toBeDropped = Int(signal.dropLast(signal.count - 7).map { String($0) }.joined(separator: ""))!
    if toBeDropped < signal.count / 2 {
      fatalError("This solution only works if the requested string is in the last half of the signal")
    }

    var interestingIndexes = Array(signal.dropFirst(toBeDropped))
    for _ in 1 ... 100 {
      var remainingSumFromBack = 0
      for index in stride(from: interestingIndexes.count - 1, through: 0, by: -1) {
        remainingSumFromBack = (remainingSumFromBack + interestingIndexes[index]) % 10
        interestingIndexes[index] = abs(remainingSumFromBack)
      }
    }

    return interestingIndexes.dropLast(interestingIndexes.count - 8).map { String($0) }.joined(separator: "")
  }
}

extension String {
  fileprivate var numbers: [Int] {
    map { Int(String($0))! }
  }
}
