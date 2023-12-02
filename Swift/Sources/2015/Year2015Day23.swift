// Created by Daniele Formichelli.

import Parsing
import Utils

/// https://adventofcode.com/2015/day/23
struct Year2015Day23: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    let instructions = input.instructions
    var state = State()
    while state.instructionPointer < instructions.count {
      instructions[state.instructionPointer].execute(on: &state)
    }
    return state.registers["b"]!
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    let instructions = input.instructions
    var state = State()
    state.registers["a"] = 1
    while state.instructionPointer < instructions.count {
      instructions[state.instructionPointer].execute(on: &state)
    }
    return state.registers["b"]!
  }
}

private struct State {
  var instructionPointer: Int = 0
  var registers: [String: Int] = [:]
}

private enum Instruction {
  case half(String)
  case triple(String)
  case increment(String)
  case jump(Int)
  case jumpIfEven(String, Int)
  case jumpIfOne(String, Int)

  func execute(on state: inout State) {
    var jumpBy = 1
    switch self {
    case .half(let register):
      state.registers[register] = state.registers[register, default: 0] / 2
    case .triple(let register):
      state.registers[register] = state.registers[register, default: 0] * 3
    case .increment(let register):
      state.registers[register] = state.registers[register, default: 0] + 1
    case .jump(let by):
      jumpBy = by
    case .jumpIfEven(let register, let by):
      if state.registers[register, default: 0].isMultiple(of: 2) {
        jumpBy = by
      }
    case .jumpIfOne(let register, let by):
      if state.registers[register, default: 0] == 1 {
        jumpBy = by
      }
    }

    state.instructionPointer += jumpBy
  }
}

extension String {
  fileprivate var instructions: [Instruction] {
    return self.lines.map {
      let split = $0.components(separatedBy: " ")
      switch split[0] {
      case "hlf":
        return .half(split[1])
      case "tpl":
        return .triple(split[1])
      case "inc":
        return .increment(split[1])
      case "jmp":
        return .jump(Int(split[1])!)
      case "jie":
        return .jumpIfEven(String(split[1].dropLast()), Int(split[2])!)
      case "jio":
        return .jumpIfOne(String(split[1].dropLast()), Int(split[2])!)
      default:
        fatalError("Unknown instruction \(split[0])")
      }
    }
  }
}
