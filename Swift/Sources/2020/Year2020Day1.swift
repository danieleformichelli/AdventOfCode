//
//  Year2020Day1.swift
//  AdventOfCode2020
//
//  Created by Daniele Formichelli on 01/12/20.
//  Copyright © 2020 Daniele Formichelli. All rights reserved.
//

import Utils

/// https://adventofcode.com/2020/day/1
struct Year2020Day1: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    let inputNumbers = input.numbers
    for (firstIndex, first) in inputNumbers.enumerated() {
      for second in inputNumbers.dropFirst(firstIndex + 1) where first + second == 2020 {
        return first * second
      }
    }

    fatalError()
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    let inputNumbers = input.numbers
    for (firstIndex, first) in inputNumbers.enumerated() {
      for (secondIndex, second) in inputNumbers.dropFirst(firstIndex + 1).enumerated() {
        for third in inputNumbers.dropFirst(secondIndex + 1) where first + second + third == 2020 {
          return first * second * third
        }
      }
    }

    fatalError()
  }
}
