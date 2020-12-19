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
    let (rules, messages) = input.rulesAndMessages
    return self.run(rules: rules, messages: messages)
  }

  public func part2(_ input: String) -> CustomDebugStringConvertible {
    var (rules, messages) = input.rulesAndMessages
    let repeated = 5
    rules[8] = .either((1 ... repeated).map { Array(repeating: 42, count: $0) })
    rules[11] = .either((1 ... repeated).map { Array(repeating: 42, count: $0) + Array(repeating: 31, count: $0) })
    return self.run(rules: rules, messages: messages)
  }

  private func run(rules: [Int: Rule], messages: [String]) -> Int {
    var cache: [Int: String] = [:]
    let regexString = regex(for: 0, rules: rules, cache: &cache)
    let regex = try! NSRegularExpression(pattern: "^\(regexString)$")
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
      result = "(\(rulesList.map { "\(self.regex(for: $0, rules: rules, cache: &cache))" }.joined()))"
    case .either(let blocks):
      result = "(\(blocks.map { $0.map { "\(self.regex(for: $0, rules: rules, cache: &cache))" }.joined() }.joined(separator: "|")))"
    }

    cache[rule] = result
    return result
  }
}

extension Year2020Day19 {
  indirect enum Rule: Hashable {
    case character(String)
    case list([Int])
    case either([[Int]])
  }
}

extension String {
  fileprivate var rulesAndMessages: (rules: [Int: Year2020Day19.Rule], messages: [String]) {
    let split = self.components(separatedBy: "\n\n")
    let rules: [Int: Year2020Day19.Rule] = Dictionary(uniqueKeysWithValues: split[0].split(separator: "\n").map { idAndRule in
      let split = idAndRule.components(separatedBy: ": ")
      let id = Int(split[0])!
      let rule = split[1].rule
      return (id, rule)
    })
    return (rules: rules, messages: split[1].lines)
  }

  fileprivate var rule: Year2020Day19.Rule {
    let ruleParts = self.split(separator: " ")
    if let orIndex = ruleParts.firstIndex(where: { $0 == "|" }) {
      return .either(
        [
          ruleParts.prefix(orIndex).compactMap { Int($0) },
          ruleParts.dropFirst(orIndex + 1).compactMap { Int($0) }
        ]
      )
    } else if ruleParts.count == 1 && Int(ruleParts[0]) == nil {
      return .character(String(ruleParts[0].dropFirst().dropLast()))
    } else {
      return .list(ruleParts.compactMap { Int($0) })
    }
  }
}
