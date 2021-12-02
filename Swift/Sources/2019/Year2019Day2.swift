// Created by Daniele Formichelli.

import Utils

/// https://adventofcode.com/2019/day/2
struct Year2019Day2: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    var memory = input.intCodeMemory
    memory[1] = 12
    memory[2] = 2
    _ = IntCode.executeProgram(memory: &memory, input: nil)

    return memory[0]!
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    let expectedResult: Int64 = 19_690_720
    let memory = input.intCodeMemory
    for noun in 0 ... 99 {
      for verb in 0 ... 99 {
        var memory = memory
        memory[1] = Int64(noun)
        memory[2] = Int64(verb)
        _ = IntCode.executeProgram(memory: &memory, input: nil)
        let result = memory[0]
        if result == expectedResult {
          return noun * 100 + verb
        }
      }
    }

    fatalError("Cannot find noun and verb which results in \(expectedResult)")
  }
}
