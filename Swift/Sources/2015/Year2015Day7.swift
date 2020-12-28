//
//  Year2015Day7.swift
//
//  Copyright © 2020 Bending Spoons. All rights reserved.
//

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

  static private func value(of id: String, instructions: [String: Instruction], cache: inout [String: Int]) -> Int {
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

fileprivate enum Instruction {
  case value(String)
  case and(String, String)
  case or(String, String)
  case not(String)
  case lShift(String, by: String)
  case rShift(String, by: String)
}

extension String {
  fileprivate var instructions: [String: Instruction] {
    let id = Prefix<Substring>(minLength: 1) { $0.isLetter || $0.isNumber }.map { $0.asString }
    let value = id.map { Instruction.value($0) }
    let and = id.skip(StartsWith(" AND ")).take(id).map { Instruction.and($0, $1) }
    let or = id.skip(StartsWith(" OR ")).take(id).map { Instruction.or($0, $1) }
    let not = StartsWith("NOT ").take(id).map { Instruction.not($0) }
    let lShift = id.skip(StartsWith(" LSHIFT ")).take(id).map { Instruction.lShift($0, by: $1) }
    let rShift = id.skip(StartsWith(" RSHIFT ")).take(id).map { Instruction.rShift($0, by: $1) }
    let instruction = and.orElse(or).orElse(not).orElse(lShift).orElse(rShift).orElse(value)
    let destinationAndInstruction = instruction.skip(StartsWith(" -> ")).take(id).map { ($1, $0) }
    let destinationsAndInstruction: [(String, Instruction)] = Many(destinationAndInstruction, separator: StartsWith("\n")).parse(self)!
    return Dictionary(uniqueKeysWithValues: destinationsAndInstruction)
  }
}
