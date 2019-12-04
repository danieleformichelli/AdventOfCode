//
//  Day4.swift
//  AdventOfCode2019
//
//  Created by Daniele Formichelli on 04/12/2019.
//  Copyright © 2019 Daniele Formichelli. All rights reserved.
//

/**
**/
struct Day4: DayBase {
  func part1(_ input: String) -> Any {
    passwordRange.filter { $0.isValidPassword() }.count
  }

  func part2(_ input: String) -> Any {
    passwordRange.filter { $0.isValidPassword(maxAdjacentCount: 2) }.count
  }
}

private extension Int {
  func isValidPassword(minAdjacentCount: Int? = 2, maxAdjacentCount: Int? = nil) -> Bool {
    var equalsAdjacentDigitsFound = false
    var adjacentDigitsCount = 0
    var remainingDigits = self
    var previousDigit = Int.max
    while remainingDigits > 0 {
      let lastDigit = remainingDigits % 10
      if lastDigit > previousDigit {
        return false
      } else if lastDigit == previousDigit {
        adjacentDigitsCount += 1
      } else {
        if let maxAdjacentCount = maxAdjacentCount {
          if adjacentDigitsCount == maxAdjacentCount {
            equalsAdjacentDigitsFound = true
          }
        } else {
          equalsAdjacentDigitsFound = true
        }
        adjacentDigitsCount = 1
      }

      remainingDigits = remainingDigits / 10
      previousDigit = lastDigit
    }

    if let maxAdjacentCount = maxAdjacentCount, adjacentDigitsCount == maxAdjacentCount {
      // handle case in which last digits are adjacent
      equalsAdjacentDigitsFound = true
    }

    return equalsAdjacentDigitsFound
  }
}

extension Day4 {
  var passwordRange: [Int] {
    self.input.components(separatedBy: "-").map { Int($0)! }
  }

  var input: String {
    """
    234208-765869
    """
  }
}
