// Created by Daniele Formichelli.

import Utils

/// https://adventofcode.com/2019/day/9
struct Year2019Day9: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    var memory = input.intCodeMemory
    return IntCode.executeProgram(memory: &memory, input: { 1 })!
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    var memory = input.intCodeMemory
    return IntCode.executeProgram(memory: &memory, input: { 2 })!
  }
}
