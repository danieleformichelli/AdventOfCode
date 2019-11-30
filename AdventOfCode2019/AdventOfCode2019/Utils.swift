//
//  Utils.swift
//  AdventOfCode2019
//
//  Created by Daniele Formichelli on 30/11/2019.
//  Copyright © 2019 Daniele Formichelli. All rights reserved.
//

import Foundation

enum Utils {
  static func readLines(from input: String) -> [String] {
    return input.components(separatedBy: "\n")
  }

  static func readLinesAsInt(from input: String) -> [Int] {
    return input.components(separatedBy: "\n").compactMap { Int($0) }
  }

  static func readSpaceSeparatedInput(from input: String) -> [String] {
    return input.components(separatedBy: " ")
  }

  static func readSpaceSeparatedMultiLineInput(from input: String) -> [[String]] {
    return input.components(separatedBy: "\n").map { $0.components(separatedBy: " ") }
  }
}
