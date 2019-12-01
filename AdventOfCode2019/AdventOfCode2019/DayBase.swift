//
//  DayBase.swift
//  AdventOfCode2019
//
//  Created by Daniele Formichelli on 30/11/2019.
//  Copyright © 2019 Daniele Formichelli. All rights reserved.
//

enum Part {
  case part1
  case part2
}

protocol DayBase {
  func part1(_ input: String) -> Any

  func part2(_ input: String) -> Any

  var input: String { get }

  var part1Input: String { get }

  var part2Input: String { get }
}

extension DayBase {
  func run(_ part: Part) -> Any {
    switch part {
    case .part1:
      return self.part1(self.part1Input)
    case .part2:
      return self.part2(self.part2Input)
    }
  }

  var part1Input: String {
    return self.input
  }

  var part2Input: String {
    return self.input
  }
}
