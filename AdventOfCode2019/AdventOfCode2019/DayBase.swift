//
//  DayBase.swift
//  AdventOfCode2019
//
//  Created by Daniele Formichelli on 01/12/2019.
//  Copyright © 2019 Daniele Formichelli. All rights reserved.
//

import Foundation

enum Part {
  case part1
  case part2
}

protocol DayBase {
  var input: String { get }

  func part1(_ input: String) -> Any

  func part2(_ input: String) -> Any
}

extension DayBase {
  func run(_ part: Part) -> Any {
    switch part {
    case .part1:
      return self.part1(self.input)
    case .part2:
      return self.part2(self.input)
    }
  }

  var inputLines: [String] {
    input.components(separatedBy: "\n")
  }

  var inputNumbers: [Int] {
    input.components(separatedBy: "\n").compactMap { Int($0) }
  }

  var inputCommaSeparatedNumbers: [Int] {
    input.components(separatedBy: ",").compactMap { Int($0) }
  }

  var inputCommaSeparatedLines: [[String]] {
    input.components(separatedBy: "\n").compactMap { $0.components(separatedBy: ",") }
  }

  var inputAsIntCodeMemory: [Int64: Int64] {
    var pairs = Array(inputCommaSeparatedNumbers.enumerated().map { (Int64($0.offset), Int64($0.element)) })
    // store relative base at address -1
    pairs.append((IntCode.relativeBaseAddress, 0))
    return Dictionary(uniqueKeysWithValues: pairs)
  }
}
