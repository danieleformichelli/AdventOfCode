//
//  Year2020Day19.swift
//  AdventOfCode2020
//
//  Created by Daniele Formichelli on 19/12/2020.
//  Copyright © 2020 Daniele Formichelli. All rights reserved.
//

import Foundation
import Utils

/// https://adventofcode.com/2020/day/19
public struct Year2020Day19: DayBase {
  public func part1(_ input: String) -> CustomDebugStringConvertible {
    var cache: [Int: String] = [:]
    let (rules, messages) = input.rulesAndMessages
    return self.run(rules: rules, messages: messages, cache: &cache)
  }

  public func part2(_ input: String) -> CustomDebugStringConvertible {
    var cache: [Int: String] = [:]
    let (rules, messages) = input.rulesAndMessages
    let regex42 = regex(for: 42, rules: rules, cache: &cache)
    let regex31 = regex(for: 31, rules: rules, cache: &cache)
    cache[8] = "(\(regex42)+)"
    // We ould need a way to say (\(regex42){N}\(regex31){N}), where N is unknown but the same for both matches. Hardcoding a small subset for now
    cache[11] = "((\(regex42)\(regex31))|(\(regex42){1}\(regex31){1})|(\(regex42){2}\(regex31){2})|(\(regex42){3}\(regex31){3})|(\(regex42){4}\(regex31){4}))"
    cache[31] = regex31
    cache[42] = regex42
    return self.run(rules: rules, messages: messages, cache: &cache)
  }

  private func run(rules: [Int: Rule], messages: [String], cache: inout [Int: String]) -> Int {
    let regexString = regex(for: 0, rules: rules, cache: &cache)
    let regex = try! NSRegularExpression(pattern: "^(\(regexString))$")
    return messages
      .filter { regex.firstMatch(in: $0, range: NSRange(location: 0, length: $0.count)) != nil}
      .count
  }

  private func regex(for rule: Int, rules: [Int: Rule], cache: inout [Int: String]) -> String {
    if let cached = cache[rule] {
      return cached
    }

    let result: String
    switch rules[rule]! {
    case .character(let character):
      result = "(\(character))"
    case .list(let rulesList):
      result = rulesList.map { "\(self.regex(for: $0, rules: rules, cache: &cache))" }.joined()
    case .either(let first, let second):
      let firstSet = first.map { "\(self.regex(for: $0, rules: rules, cache: &cache))" }.joined()
      let secondSet = second.map { "\(self.regex(for: $0, rules: rules, cache: &cache))" }.joined()
      result = "((\(firstSet))|(\(secondSet)))"
    }
    cache[rule] = result
    return result
  }
}

extension Year2020Day19 {
  indirect enum Rule: Hashable {
    case character(String)
    case list([Int])
    case either(first: [Int], second: [Int])
  }
}

extension String {
  fileprivate var rulesAndMessages: (rules: [Int: Year2020Day19.Rule], messages: [String]) {
    let split = self.components(separatedBy: "\n\n")
    let rules: [Int: Year2020Day19.Rule] = Dictionary(uniqueKeysWithValues: split[0].split(separator: "\n").map { idAndRule in
      let split = idAndRule.components(separatedBy: ": ")
      let id = Int(split[0])!
      return (id, split[1].rule)
    })
    return (rules: rules, messages: split[1].lines)
  }

  fileprivate var rule: Year2020Day19.Rule {
    let ruleParts = self.split(separator: " ")
    if let orIndex = ruleParts.firstIndex(where: { $0 == "|" }) {
      return .either(
        first: ruleParts.prefix(orIndex).compactMap { Int($0) },
        second: ruleParts.dropFirst(orIndex + 1).compactMap { Int($0) }
      )
    } else if ruleParts.count == 1 && Int(ruleParts[0]) == nil {
      return .character(String(ruleParts[0].dropFirst().dropLast()))
    } else {
      return .list(ruleParts.compactMap { Int($0) })
    }
  }
}
