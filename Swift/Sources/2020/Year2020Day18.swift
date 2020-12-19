//
//  Year2020Day18.swift
//  AdventOfCode2020
//
//  Created by Daniele Formichelli on 18/12/2020.
//  Copyright © 2020 Daniele Formichelli. All rights reserved.
//

import Utils

/// https://adventofcode.com/2020/day/18
public struct Year2020Day18: DayBase {
  public func part1(_ input: String) -> CustomDebugStringConvertible {
    return input.lines.map { self.solve($0, precedence: .same).result }.sum
  }

  public func part2(_ input: String) -> CustomDebugStringConvertible {
    return input.lines.map { self.solve($0, precedence: .sumFirst).result }.sum
  }

  private func solve(_ input: String, from startIndex: Int = 0, precedence: Precedence) -> (result: Int, endIndex: Int) {
    var operators: [Operator] = []
    var numbers: [Int] = []
    var index = startIndex
    while index < input.count {
      let character = input[input.index(input.startIndex, offsetBy: index)]
      switch character {
      case " ":
        break
      case "+":
        operators.append(.sum)
      case "*":
        operators.append(.product)
      case "(":
        let (partialResult, endIndex) = self.solve(input, from: index + 1, precedence: precedence)
        numbers.append(partialResult)
        index = endIndex
      case ")":
        return (result: compute(numbers: numbers, operators: operators, precedence: precedence), endIndex: index)
      default:
        numbers.append(Int(String(character))!)
      }
      index += 1
    }
    return (result: compute(numbers: numbers, operators: operators, precedence: precedence), endIndex: index)
  }

  private func compute(numbers: [Int], operators: [Operator], precedence: Precedence) -> Int {
    var numbers = numbers
    var operators = operators
    while !operators.isEmpty {
      let nextOperatorIndex = precedence.nextOperatorIndex(in: operators)
      let nextOperator = operators.remove(at: nextOperatorIndex)
      let left = numbers.remove(at: nextOperatorIndex)
      let right = numbers.remove(at: nextOperatorIndex)
      numbers.insert(nextOperator.compute(left, right), at: nextOperatorIndex)
    }
    return numbers[0]
  }
}

extension Year2020Day18 {
  fileprivate enum Precedence {
    case same
    case sumFirst

    func nextOperatorIndex(in operators: [Operator]) -> Int {
      switch self {
      case .same:
        return 0
      case .sumFirst:
        return operators.firstIndex(of: .sum) ?? 0
      }
    }
  }

  fileprivate enum Operator {
    case product
    case sum

    func compute(_ left: Int, _ right: Int) -> Int {
      switch  self {
      case .product:
        return left * right
      case .sum:
        return left + right
      }
    }
  }
}
