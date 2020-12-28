//
//  Year2015Day12.swift
//
//  Copyright © 2020 Bending Spoons. All rights reserved.
//

import Foundation
import Parsing
import Utils

/// https://adventofcode.com/2015/day/12
struct Year2015Day12: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    var sum = 0
    var currentNumber = ""
    var index = input.startIndex
    while index < input.endIndex {
      let char = input[index]
      if char == "-" || char.isNumber {
        currentNumber.append(char)
      } else if !currentNumber.isEmpty {
        sum += Int(currentNumber)!
        currentNumber = ""
      }
      index = input.index(after: index)
    }

    if !currentNumber.isEmpty {
      sum += Int(currentNumber)!
    }

    return sum
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    return Self.sum(json: try! JSONSerialization.jsonObject(with: input.data(using: .utf8)!, options: []))
  }

  static private func sum(json: Any) -> Int {
    if let jsonArray = json as? [Any] {
      return jsonArray.map { Self.sum(json: $0) }.sum
    } else if let jsonDictionary = json as? [String: Any] {
      guard !jsonDictionary.contains(where: { $0.value as? String == "red" }) else {
        return 0
      }
      return jsonDictionary.values.map { Self.sum(json: $0) }.sum
    } else if let jsonInt = json as? Int {
      return jsonInt
    } else {
      return 0
    }
  }
}
