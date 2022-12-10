// Created by Daniele Formichelli.

import Foundation
import Utils

/// https://adventofcode.com/2022/day/10
struct Year2022Day10: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    var x = 1
    var cycle = 0
    var cycleToSignal = [0: 1]
    input.instructions.forEach { instruction in
      switch instruction {
      case .noop:
        cycle += 1
        cycleToSignal[cycle] = x
      case .addX(let value):
        cycleToSignal[cycle + 1] = x
        cycleToSignal[cycle + 2] = x
        cycle += 2
        x += value
      }
    }
    return [20, 60, 100, 140, 180, 220]
      .map { cycle in
        return cycle * cycleToSignal[cycle, default: 0]
      }
      .sum
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    var x = 1
    var cycle = 0
    var output = ""
    input.instructions.forEach { instruction in
      switch instruction {
      case .noop:
        cycle += 1
        if (cycle - 1) % 40 >= x - 1 && (cycle - 1) % 40 <= x + 1 {
          output += "#"
        } else {
          output += "."
        }
      case .addX(let value):
        if cycle % 40 >= x - 1 && cycle % 40 <= x + 1 {
          output += "#"
        } else {
          output += "."
        }
        if (cycle + 1) % 40 >= x - 1 && (cycle + 1) % 40 <= x + 1 {
          output += "#"
        } else {
          output += "."
        }
        cycle += 2
        x += value
      }
    }
    var outputByLine = ""
    while output.count > 0 {
      outputByLine += output.prefix(40) + "\n"
      output = String(output.dropFirst(40))
    }
    return outputByLine
  }
}

enum Instruction {
  case noop
  case addX(Int)
}

extension String {
  var instructions: [Instruction] {
    return self.lines.map { line in
      let split = line.split(separator: " ")
      if split.count == 2 {
        return .addX(Int(split[1])!)
      } else {
        return .noop
      }
    }
  }
}
