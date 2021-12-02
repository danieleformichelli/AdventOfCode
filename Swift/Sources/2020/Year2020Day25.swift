// Created by Daniele Formichelli.

import Foundation
import Utils

/// https://adventofcode.com/2020/day/25
public struct Year2020Day25: DayBase {
  public func part1(_ input: String) -> CustomDebugStringConvertible {
    let publicKeys = input.numbers
    let loopSizes = publicKeys.map { self.findLoopSize(subject: 7, result: $0) }
    let encryptionKey1 = self.transform(subject: publicKeys[1], loopSize: loopSizes[0])
    let encryptionKey0 = self.transform(subject: publicKeys[0], loopSize: loopSizes[1])
    guard encryptionKey0 == encryptionKey1 else {
      fatalError()
    }
    return encryptionKey1
  }

  public func part2(_: String) -> CustomDebugStringConvertible {
    return ""
  }

  private func transform(subject: Int, loopSize: Int) -> Int {
    var result = 1
    (1 ... loopSize).forEach { _ in
      result = result * subject % 20_201_227
    }
    return result
  }

  private func findLoopSize(subject: Int, result expectedResult: Int) -> Int {
    var result = 1
    var loopSize = 1
    while true {
      result = result * subject % 20_201_227
      if result == expectedResult {
        return loopSize
      }
      loopSize += 1
    }
    return result
  }
}
