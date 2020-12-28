//
//  Year2015Day13.swift
//
//  Copyright © 2020 Bending Spoons. All rights reserved.
//

import Parsing
import Utils

/// https://adventofcode.com/2015/day/13
struct Year2015Day13: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    return Self.run(happinessChanges: input.happinessChanges)
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    let myself = "Z"
    var happinessChanges = input.happinessChanges
    happinessChanges[myself] = [:]
    for person in happinessChanges.keys {
      happinessChanges[myself]?[person] = 0
      happinessChanges[person]?[myself] = 0
    }
    return Self.run(happinessChanges: happinessChanges)
  }

  private static func run(happinessChanges: [String: [String: Int]]) -> Int {
    var maxHappiness = 0
    for arrangement in happinessChanges.keys.asArray.permutations {
      var happiness = 0
      for i in 0 ..< arrangement.count {
        let currentSeat = arrangement[i]
        let previousSeat = arrangement[(i + arrangement.count - 1) % arrangement.count]
        let nextSeat = arrangement[(i + 1) % arrangement.count]
        happiness += happinessChanges[currentSeat]![previousSeat]!
        happiness += happinessChanges[currentSeat]![nextSeat]!
      }
      maxHappiness = max(maxHappiness, happiness)
    }
    return maxHappiness
  }
}

extension String {
  fileprivate var happinessChanges: [String: [String: Int]] {
    let name = Prefix<Substring>(minLength: 0) { $0.isLetter }.map { $0.asString }
    let multiplier = StartsWith<Substring>(" would gain ").map { 1 }
      .orElse(StartsWith(" would lose ").map { -1 })
    let entry = name
      .take(multiplier)
      .take(Int.parser())
      .skip(StartsWith(" happiness units by sitting next to "))
      .take(name)
      .skip(StartsWith("."))
      .map {
        return ($0, $3, $1 * $2)
      }
    let happinessChanges = Many(entry, separator: StartsWith("\n")).parse(self)!
    return happinessChanges.reduce(into: [:]) { result, value in
      var current = result[value.0] ?? [:]
      current[value.1] = value.2
      result[value.0] = current
    }
  }
}
