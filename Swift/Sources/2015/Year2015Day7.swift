// Created by Daniele Formichelli.

import Parsing
import Utils

/// https://adventofcode.com/2015/day/7
struct Year2015Day7: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    var cache: [String: Int] = [:]
    return Self.value(of: "a", instructions: input.instructions, cache: &cache)
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    let instructions = input.instructions
    var cache: [String: Int] = [:]
    let overriddenB = Self.value(of: "a", instructions: instructions, cache: &cache)
    cache = ["b": overriddenB]
    return Self.value(of: "a", instructions: instructions, cache: &cache)
  }

  private static func value(of id: String, instructions: [String: Instruction], cache: inout [String: Int]) -> Int {
    print("DF: \(id)")
    if let intValue = Int(id) {
      return intValue
    }

    if let cached = cache[id] {
      return cached
    }

    let instruction = instructions[id]!
    let value: Int
    switch instruction {
    case .value(let other):
      value = Self.value(of: other, instructions: instructions, cache: &cache)
    case .and(let first, let second):
      let firstValue = Self.value(of: first, instructions: instructions, cache: &cache)
      let secondValue = Self.value(of: second, instructions: instructions, cache: &cache)
      value = firstValue & secondValue
    case .or(let first, let second):
      let firstValue = Self.value(of: first, instructions: instructions, cache: &cache)
      let secondValue = Self.value(of: second, instructions: instructions, cache: &cache)
      value = firstValue | secondValue
    case .not(let other):
      let otherValue = Self.value(of: other, instructions: instructions, cache: &cache)
      value = ~otherValue
    case .lShift(let other, let by):
      let otherValue = Self.value(of: other, instructions: instructions, cache: &cache)
      let byValue = Self.value(of: by, instructions: instructions, cache: &cache)
      value = otherValue << byValue
    case .rShift(let other, let by):
      let otherValue = Self.value(of: other, instructions: instructions, cache: &cache)
      let byValue = Self.value(of: by, instructions: instructions, cache: &cache)
      value = otherValue >> byValue
    }

    cache[id] = value
    return value
  }
}

private enum Instruction {
  case value(String)
  case and(String, String)
  case or(String, String)
  case not(String)
  case lShift(String, by: String)
  case rShift(String, by: String)
}

extension String {
  fileprivate var instructions: [String: Instruction] {
    return Dictionary(uniqueKeysWithValues: self.lines.map {
      let split = $0.components(separatedBy: " -> ")
      let id = split[1]
      let instructionString = split[0]
      let instruction: Instruction
      if instructionString.starts(with: "NOT") {
        instruction = .not(String(instructionString[instructionString.index(instructionString.startIndex, offsetBy: 4)...]))
      } else if instructionString.contains(" AND ") {
        let instructionSplit = instructionString.components(separatedBy: " AND ")
        instruction = .and(instructionSplit[0], instructionSplit[1])
      } else if instructionString.contains(" OR ") {
        let instructionSplit = instructionString.components(separatedBy: " OR ")
        instruction = .or(instructionSplit[0], instructionSplit[1])
      } else if instructionString.contains(" LSHIFT ") {
        let instructionSplit = instructionString.components(separatedBy: " LSHIFT ")
        instruction = .lShift(instructionSplit[0], by: instructionSplit[1])
      } else if instructionString.contains(" LSHIFT ") {
        let instructionSplit = instructionString.components(separatedBy: " LSHIFT ")
        instruction = .rShift(instructionSplit[0], by: instructionSplit[1])
      } else {
        instruction = .value(instructionString)
      }
      return (id, instruction)
    })
  }
}
