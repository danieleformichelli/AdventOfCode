// Created by Daniele Formichelli.

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
    return Dictionary(uniqueKeysWithValues: self.lines.enumerated().map { index, line in
      // Sue 291: akitas: 0, pomeranians: 7, vizslas: 4
      let dropped = line.drop(while: { $0 != " "}).drop(while: { $0 != " "}).dropFirst()
      let compounds = dropped.components(separatedBy: ",")
      return (index + 1, compounds.reduce(into: [:], { result, compound in
        let split = compound.components(separatedBy: ": ")
        result[split[0]] = Int(split[1])!
      }))
    })
  }
}
