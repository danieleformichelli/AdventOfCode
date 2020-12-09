//
//  Year2020Day9.swift
//  AdventOfCode2020
//
//  Created by Daniele Formichelli on 09/12/2020.
//  Copyright © 2020 Daniele Formichelli. All rights reserved.
//

import Utils

/// https://adventofcode.com/2020/day/9
public struct Year2020Day9: DayBase {
  public func part1(_ input: String) -> CustomDebugStringConvertible {
    return self.findInvalidElement(in: input.numbers)
  }

  public func part2(_ input: String) -> CustomDebugStringConvertible {
    let numbers = input.numbers
    let invalidElement = self.findInvalidElement(in: numbers)
    var minSequenceIndex = 0
    var maxSequenceIndex = 0
    var currentValue = numbers[0]
    while currentValue != invalidElement {
      if currentValue < invalidElement {
        currentValue += numbers[maxSequenceIndex]
        maxSequenceIndex += 1
      } else {
        currentValue -= numbers[minSequenceIndex]
        minSequenceIndex += 1
      }
    }

    let sequence = numbers[minSequenceIndex...maxSequenceIndex]
    return sequence.min()! + sequence.max()!
  }

  private func findInvalidElement(in numbers: [Int]) -> Int {
    for index in 25..<numbers.count where !self.hasAddends(at: index, in: numbers) {
      return numbers[index]
    }
    fatalError()
  }

  private func hasAddends(at index: Int, in numbers: [Int]) -> Bool {
    let number = numbers[index]
    let firstIndex = index - 25
    for i in firstIndex ..< index {
      for j in i + 1 ..< index where numbers[i] + numbers[j] == number {
        return true
      }
    }
    return false
  }
}
