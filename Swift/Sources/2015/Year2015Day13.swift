// Created by Daniele Formichelli.

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
    return self.lines.reduce(into: [:]) { result, line in
      let split = line.components(separatedBy: " happiness units by sitting next to ")
      let other = split[1]
      
      let whoSplit = split[0].components(separatedBy: " would ")
      let who = split[0]
      
      let changeSplit = whoSplit[1].components(separatedBy: " ")
      let value: Int
      switch changeSplit[0] {
      case "gain":
        value = Int(changeSplit[1])!
      case "lose":
        value = -Int(changeSplit[1])!
      default:
        fatalError("Unknown multiplier \(changeSplit[0])")
      }
      
      var current = result[who] ?? [:]
      current[other] = value
      result[who] = current
    }
  }
}
