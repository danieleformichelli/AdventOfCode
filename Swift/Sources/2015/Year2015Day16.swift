// Created by Daniele Formichelli.

import Parsing
import Utils

/// https://adventofcode.com/2015/day/16
struct Year2015Day16: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    return input.auntAndCompounds
      .filter { _, compounds in
        return compounds.allSatisfy { compound, amount in
          Self.mfcsam[compound] == amount
        }
      }
      .keys
      .first!
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    return input.auntAndCompounds
      .filter { _, compounds in
        return compounds.allSatisfy { compound, amount in
          switch compound {
          case "cats", "trees":
            return Self.mfcsam[compound]! < amount
          case "pomeranians", "goldfish":
            return Self.mfcsam[compound]! > amount
          default:
            return Self.mfcsam[compound] == amount
          }
        }
      }
      .keys
      .first!
  }

  private static var mfcsam: [String: Int] {
    return [
      "children": 3,
      "cats": 7,
      "samoyeds": 2,
      "pomeranians": 3,
      "akitas": 0,
      "vizslas": 0,
      "goldfish": 5,
      "trees": 3,
      "cars": 2,
      "perfumes": 1,
    ]
  }
}

extension String {
  fileprivate var auntAndCompounds: [Int: [String: Int]] {
    let name = Prefix<Substring>(minLength: 0) { $0.isLetter }.map(\.asString)
    let compounds = name.skip(StartsWith(": ")).take(Int.parser()).map { ($0, $1) }

    let auntAndCompounds = Skip(StartsWith("Sue "))
      .take(Int.parser())
      .skip(StartsWith(": "))
      .take(Many(compounds, atLeast: 3, separator: StartsWith(", ")))
      .map {
        return ($0, Dictionary(uniqueKeysWithValues: $1))
      }

    return Dictionary(uniqueKeysWithValues: Many(auntAndCompounds, separator: StartsWith("\n")).parse(self)!)
  }
}
