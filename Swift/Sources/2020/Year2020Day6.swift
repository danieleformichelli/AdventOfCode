//
//  Year2020Day6.swift
//  AdventOfCode2020
//
//  Created by Daniele Formichelli on 06/12/2020.
//  Copyright © 2020 Daniele Formichelli. All rights reserved.
//

import Utils

/// https://adventofcode.com/2020/day/6
public struct Year2020Day6: DayBase {
  public func part1(_ input: String) -> CustomDebugStringConvertible {
    input.groups
      .map { group in
        group.joined().asSet.count
      }
      .sum
  }

  public func part2(_ input: String) -> CustomDebugStringConvertible {
    input.groups
      .map { group -> Int in
        var everyoneAnswered = group.first ?? []
        group.forEach { answers in
          everyoneAnswered = everyoneAnswered.filter { answers.contains($0) }
        }
        return everyoneAnswered.asSet.count
      }
      .sum
  }
}

extension Year2020Day6 {
  typealias Answers = Set<Character>
  typealias Group = Set<Answers>
}

extension String {
  var groups: Set<Year2020Day6.Group> {
    Set(
      components(separatedBy: "\n\n")
        .map { group in
          Set(
            group
              .split(separator: "\n")
              .map { Set($0.map { $0 }) }
          )
        }
    )
  }
}
