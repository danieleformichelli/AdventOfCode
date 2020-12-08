//
//  Year2020Day8.swift
//  AdventOfCode2020
//
//  Created by Daniele Formichelli on 08/12/2020.
//  Copyright © 2020 Daniele Formichelli. All rights reserved.
//

import Utils

/// https://adventofcode.com/2020/day/8
public struct Year2020Day8: DayBase {
  public func part1(_ input: String) -> CustomDebugStringConvertible {
    do {
      return try input.operations.execute()
    } catch {
      switch error as! Operation.Error {
      case .loop(_, let currentResult):
        return currentResult
      }
    }
  }

  public func part2(_ input: String) -> CustomDebugStringConvertible {
    let initialOperations = input.operations
    var jmpsAndNops: Set<Int> = initialOperations.enumerated()
      .compactMap { index, operations in
        switch operations {
        case .acc:
          return nil
        case .jmp, .nop:
          return index
        }
      }
      .asSet

    while true {
      var operations = initialOperations
      let nextJmpsAndNops = jmpsAndNops.removeFirst()
      switch operations[nextJmpsAndNops] {
      case .acc:
        fatalError()
      case .jmp(let by):
        operations[nextJmpsAndNops] = .nop(arg: by)
      case .nop(let arg):
        operations[nextJmpsAndNops] = .jmp(by: arg)
      }

      do {
        return try operations.execute()
      } catch {
        continue
      }
    }
  }
}
