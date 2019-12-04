//
//  Day4.swift
//  AdventOfCode2019
//
//  Created by Daniele Formichelli on 04/12/2019.
//  Copyright © 2019 Daniele Formichelli. All rights reserved.
//

/**
--- Day 4: Secure Container ---
You arrive at the Venus fuel depot only to discover it's protected by a password. The Elves had written the password on a sticky note, but someone threw it out.

However, they do remember a few key facts about the password:

It is a six-digit number.
The value is within the range given in your puzzle input.
Two adjacent digits are the same (like 22 in 122345).
Going from left to right, the digits never decrease; they only ever increase or stay the same (like 111123 or 135679).
Other than the range rule, the following are true:

111111 meets these criteria (double 11, never decreases).
223450 does not meet these criteria (decreasing pair of digits 50).
123789 does not meet these criteria (no double).
How many different passwords within the range given in your puzzle input meet these criteria?

Your puzzle answer was 1246.

--- Part Two ---
An Elf just remembered one more important detail: the two adjacent matching digits are not part of a larger group of matching digits.

Given this additional criterion, but still ignoring the range rule, the following are now true:

112233 meets these criteria because the digits never decrease and all repeated digits are exactly two digits long.
123444 no longer meets the criteria (the repeated 44 is part of a larger group of 444).
111122 meets the criteria (even though 1 is repeated more than twice, it still contains a double 22).
How many different passwords within the range given in your puzzle input meet all of the criteria?

Your puzzle answer was 814.
**/
struct Day4: DayBase {
  func part1(_ input: String) -> Any {
    self.passwordRange.filter { $0.isValidPassword() }.count
  }

  func part2(_ input: String) -> Any {
    self.passwordRange.filter { $0.isValidPassword(maxAdjacentCount: 2) }.count
  }
}

private extension Int {
  func isValidPassword(minAdjacentCount: Int = 2, maxAdjacentCount: Int = Int.max) -> Bool {
    let validAdjacentCountRange = minAdjacentCount...maxAdjacentCount
    var equalsAdjacentDigitsFound = false
    var adjacentDigitsCount = 0
    var remainingDigits = self
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

extension Day4 {
  var passwordRange: ClosedRange<Int> {
    let rangeLimits = self.input.components(separatedBy: "-").map { Int($0)! }
    return rangeLimits[0]...rangeLimits[1]
  }

  var input: String {
    """
    234208-765869
    """
  }
}
