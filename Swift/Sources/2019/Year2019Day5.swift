// Created by Daniele Formichelli.

import Utils

/// https://adventofcode.com/2019/day/5
struct Year2019Day5: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    self.executeProgram(memory: input.intCodeMemory, input: { 1 })
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    self.executeProgram(memory: input.intCodeMemory, input: { 5 })
  }

  private func executeProgram(memory: [Int64: Int64], input: @escaping () -> Int64) -> Int64 {
    var memory = memory
    var address: Int64 = 0
    var lastReturnValue: Int64?
    while address >= 0 {
      let returnValue = IntCode.executeProgram(memory: &memory, from: &address, stopOnWrite: true, input: input)
      if let returnValue = returnValue {
        lastReturnValue = returnValue
      }
    }

    return lastReturnValue!
  }
}
