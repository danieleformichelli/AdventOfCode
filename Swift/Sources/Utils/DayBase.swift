//
//  DayBase.swift
//  AdventOfCode2019
//
//  Created by Daniele Formichelli on 01/12/2019.
//  Copyright © 2019 Daniele Formichelli. All rights reserved.
//

import Foundation

public enum Part {
  case part1
  case part2
}

public protocol DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible
  func part2(_ input: String) -> CustomDebugStringConvertible
}

public extension DayBase {
  func run(part: Part, input: String) -> CustomDebugStringConvertible {
    switch part {
    case .part1:
      return part1(input)
    case .part2:
      return part2(input)
    }
  }
}
