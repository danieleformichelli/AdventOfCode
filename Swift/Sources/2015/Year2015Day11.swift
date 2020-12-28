//
//  Year2015Day11.swift
//
//  Copyright © 2020 Bending Spoons. All rights reserved.
//

import Parsing
import Utils

/// https://adventofcode.com/2015/day/11
struct Year2015Day11: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    return input.nextValid
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    return input.nextValid.nextValid
  }
}

extension String {
  fileprivate var nextValid: String {
    var current = self
    repeat {
      current = current.next
    } while !current.isValid
    return current
  }

  fileprivate var next: String {
    var characters = self.asArray
    let indexToIncrease = characters.lastIndex { $0 != "z" }!
    if indexToIncrease < characters.count - 1 {
      for index in indexToIncrease + 1 ... characters.count - 1 {
        characters[index] = "a"
      }
    }
    characters[indexToIncrease] = Character(UnicodeScalar(characters[indexToIncrease].asciiValue! + 1))
    return String(characters)
  }

  fileprivate var isValid: Bool {
    let forbidden: Set<Character> = ["i", "o", "l"]
    guard !self.contains(where: { forbidden.contains($0) }) else {
      return false
    }

    var index = self.startIndex
    var lastIndexToCheck = self.index(self.endIndex, offsetBy: -2)
    while index < lastIndexToCheck {
      let ascii1 = self[index].asciiValue!
      let ascii2 = self[self.index(index, offsetBy: 1)].asciiValue!
      let ascii3 = self[self.index(index, offsetBy: 2)].asciiValue!
      if ascii3 == ascii2 + 1 && ascii2 == ascii1 + 1 {
        break
      }
      index = self.index(after: index)
    }

    guard index != lastIndexToCheck else {
      return false
    }

    var pairs: Set<Character> = []
    index = self.startIndex
    lastIndexToCheck = self.index(self.endIndex, offsetBy: -1)
    while index < lastIndexToCheck {
      let current = self[index]
      index = self.index(after: index)
      let next = self[index]
      if current == next {
        pairs.insert(current)
      }
    }

    return pairs.count > 1
  }
}
