//
//  Year2020Day15.swift
//  AdventOfCode2020
//
//  Created by Daniele Formichelli on 15/12/2020.
//  Copyright © 2020 Daniele Formichelli. All rights reserved.
//

import Utils

/// https://adventofcode.com/2020/day/15
public struct Year2020Day15: DayBase {
  public func part1(_ input: String) -> CustomDebugStringConvertible {
    self.spoken(at: 2020, for: input)
  }

  public func part2(_ input: String) -> CustomDebugStringConvertible {
    self.spoken(at: 30_000_000, for: input)
  }

  private func spoken(at index: Int, for input: String) -> Int {
    let numbers = input.commaSeparatedNumbers
    var nextSpokenIndex = numbers.count
    var lastSpokenIndexes = Dictionary(uniqueKeysWithValues: numbers.dropLast().enumerated().map { ($1, $0) })
    var lastSpoken = numbers.last!
    while nextSpokenIndex < index {
      let nextSpoken: Int
      if let lastSpokenIndex = lastSpokenIndexes[lastSpoken] {
        nextSpoken = nextSpokenIndex - lastSpokenIndex - 1
      } else {
        nextSpoken = 0
      }
      lastSpokenIndexes[lastSpoken] = nextSpokenIndex - 1
      lastSpoken = nextSpoken
      nextSpokenIndex += 1
    }
    return lastSpoken
  }
}
