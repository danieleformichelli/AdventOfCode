//
//  Year2020Day14.swift
//  AdventOfCode2020
//
//  Created by Daniele Formichelli on 14/12/2020.
//  Copyright © 2020 Daniele Formichelli. All rights reserved.
//

import Utils

/// https://adventofcode.com/2020/day/14
public struct Year2020Day14: DayBase {
  public func part1(_ input: String) -> CustomDebugStringConvertible {
    var andMask = Int.max
    var orMask = 0
    var memory: [Int: Int] = [:]
    for operation in input.operations {
      switch operation {
      case .mask(let and, let or, _):
        andMask = and
        orMask = or
      case .write(let value, let address):
        memory[address] = value & andMask | orMask
      }
    }
    return memory.values.sum
  }

  public func part2(_ input: String) -> CustomDebugStringConvertible {
    var orMask = 0
    var floatingMask: Set<Int> = []
    var memory: [Int: Int] = [:]
    for operation in input.operations {
      switch operation {
      case .mask(_, let or, let floating):
        orMask = or
        floatingMask = floating
      case .write(let value, let address):
        var maskedAddresses = [address | orMask]
        for floatingBit in floatingMask {
          maskedAddresses = maskedAddresses.map { $0 | 1 << floatingBit }
          maskedAddresses.append(contentsOf: maskedAddresses.map { $0 & ~(1 << floatingBit) })
        }
        for maskedAddress in maskedAddresses {
          memory[maskedAddress] = value
        }
      }
    }
    return memory.values.sum
  }
}

extension Year2020Day14 {
  enum Operation {
    case mask(and: Int, or: Int, floating: Set<Int>)
    case write(value: Int, address: Int)
  }
}

extension String {
  fileprivate var operations: [Year2020Day14.Operation] {
    return self.lines.map { line in
      let split = line.components(separatedBy: " = ")
      switch split[0] {
      case "mask":
        var and = Int.max
        var or = 0
        var floating: Set<Int> = []
        split[1].reversed().enumerated().forEach { index, bit in
          switch bit {
          case "0":
            and &= ~(1 << index)
          case "1":
            or |= 1 << index
          default:
            floating.insert(index)
          }
        }
        return .mask(and: and, or: or, floating: floating)
      default:
        let address = Int(split[0].drop { $0 != "[" }.dropFirst().dropLast(1))!
        let value = Int(split[1])!
        return .write(value: value, address: address)
      }
    }
  }
}
