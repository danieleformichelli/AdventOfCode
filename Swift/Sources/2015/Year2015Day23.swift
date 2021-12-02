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
    let name = Prefix<Substring>(minLength: 0) { $0.isLetter }.map(\.asString)
    let half = Skip(StartsWith("hlf ")).take(name).map { Instruction.half($0) }
    let triple = Skip(StartsWith("tpl ")).take(name).map { Instruction.triple($0) }
    let increment = Skip(StartsWith("inc ")).take(name).map { Instruction.increment($0) }
    let jump = Skip(StartsWith("jmp ")).take(Int.parser()).map { Instruction.jump($0) }
    let jumpIfEven = Skip(StartsWith("jie "))
      .take(name)
      .skip(StartsWith(", "))
      .take(Int.parser())
      .map { Instruction.jumpIfEven($0, $1) }
    let jumpIfOne = Skip(StartsWith("jio "))
      .take(name)
      .skip(StartsWith(", "))
      .take(Int.parser())
      .map { Instruction.jumpIfOne($0, $1) }
    let instruction = half.orElse(triple).orElse(increment).orElse(jump).orElse(jumpIfEven).orElse(jumpIfOne)
    return Many(instruction, separator: StartsWith("\n")).parse(self)!
  }
}
