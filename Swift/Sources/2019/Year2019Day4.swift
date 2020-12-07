//
//  Year2019Day4.swift
//  AdventOfCode2019
//
//  Created by Daniele Formichelli on 04/12/2019.
//  Copyright © 2019 Daniele Formichelli. All rights reserved.
//

import Utils

/// https://adventofcode.com/2019/day/4
struct Year2019Day4: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    input.passwordRange.filter { Self.isValidPassword($0) }.count
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    input.passwordRange.filter { Self.isValidPassword($0, maxAdjacentCount: 2) }.count
  }

  private static func isValidPassword(_ password: Int, minAdjacentCount: Int = 2, maxAdjacentCount: Int = Int.max) -> Bool {
    let validAdjacentCountRange = minAdjacentCount ... maxAdjacentCount
    var equalsAdjacentDigitsFound = false
    var adjacentDigitsCount = 0
    var remainingDigits = password
    var lastDigit = Int.max
    while remainingDigits > 0 {
      let previousLastDigit = lastDigit
      (remainingDigits, lastDigit) = remainingDigits.quotientAndRemainder(dividingBy: 10)
      if lastDigit > previousLastDigit {
        return false
      } else if lastDigit == previousLastDigit {
        adjacentDigitsCount += 1
      } else {
        if validAdjacentCountRange.contains(adjacentDigitsCount) {
          equalsAdjacentDigitsFound = true
        }
        adjacentDigitsCount = 1
      }
    }

    if validAdjacentCountRange.contains(adjacentDigitsCount) {
      // handle case in which last digits are adjacent
      equalsAdjacentDigitsFound = true
    }

    return equalsAdjacentDigitsFound
  }
}

extension String {
  var passwordRange: ClosedRange<Int> {
    let rangeLimits = components(separatedBy: "-").map { Int($0)! }
    return rangeLimits[0] ... rangeLimits[1]
  }
}
