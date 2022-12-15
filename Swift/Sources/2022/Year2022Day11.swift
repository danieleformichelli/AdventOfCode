// Created by Daniele Formichelli.

import Foundation
import Utils

/// https://adventofcode.com/2022/day/11
struct Year2022Day11: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    return Self.solve(input: input, divideBy: 3, rounds: 20)
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    return Self.solve(input: input, divideBy: 1, rounds: 10000)
  }

  static func solve(input: String, divideBy: Int, rounds: Int) -> Int {
    var monkeys = input.monkeys
    var inspections: [Int: Int] = [:]
    let mcm = monkeys.map(\.test.if).multiply
    for round in 0 ..< rounds {
      print("Round \(round)")
      for m in 0 ..< monkeys.count {
        print("Monkey \(m)")
        let monkey = monkeys[m]
        inspections[m] = inspections[m, default: 0] + monkey.items.count
        for item in monkey.items {
          let newLevel = (monkey.operation.apply(to: item) / divideBy) % mcm
          if newLevel % monkey.test.if == 0 {
            monkeys[monkey.test.then].items.append(newLevel)
          } else {
            monkeys[monkey.test.else].items.append(newLevel)
          }
        }
        monkeys[m].items = []
      }
    }

    return inspections.values.sorted().suffix(2).multiply
  }
}

enum Operation {
  case add(Int)
  case mul(Int)
  case square

  func apply(to value: Int) -> Int {
    switch self {
    case .add(let other):
      return value + other
    case .mul(let other):
      return value * other
    case .square:
      return value * value
    }
  }
}

struct Monkey {
  var items: [Int]
  let operation: Operation
  let test: (if: Int, then: Int, else: Int)
}

extension String {
  var monkeys: [Monkey] {
    return self.split(separator: "\n\n").map { monkeyString in
      let lines = String(monkeyString).lines

      let items = lines[1].dropFirst("  Starting items: ".count).split(separator: ", ").map { Int(String($0))! }

      let operationString = lines[2].dropFirst("  Operation: new = old ".count)
      let operatorSymbol = operationString.first!
      let operand = operationString.dropFirst(2)
      let operation: Operation
      switch operatorSymbol {
      case "+":
        operation = .add(Int(String(operand))!)
      case "*":
        if operand != "old" {
          operation = .mul(Int(String(operand))!)
        } else {
          operation = .square
        }
      default:
        fatalError("Unknown operation: \(operatorSymbol)")
      }

      let ifValue = Int(String(lines[3].dropFirst("  Test: divisible by ".count)))!
      let thenValue = Int(String(lines[4].dropFirst("    If true: throw to monkey ".count)))!
      let elseValue = Int(String(lines[5].dropFirst("    If false: throw to monkey ".count)))!

      return Monkey(items: items, operation: operation, test: (if: ifValue, then: thenValue, else: elseValue))
    }
  }
}
