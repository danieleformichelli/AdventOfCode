// Created by Daniele Formichelli.

import Foundation

public enum Part {
  case part1
  case part2
}

public protocol DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible
  func part2(_ input: String) -> CustomDebugStringConvertible
}

extension DayBase {
  public func run(part: Part, input: String) -> CustomDebugStringConvertible {
    switch part {
    case .part1:
      return part1(input)
    case .part2:
      return part2(input)
    }
  }
}
