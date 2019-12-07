//
//  Day7.swift
//  AdventOfCode2019
//
//  Created by Daniele Formichelli on 07/12/2019.
//  Copyright © 2019 Daniele Formichelli. All rights reserved.
//

/**
**/
struct Day7: DayBase {
  func part1(_ input: String) -> Any {
    let amplifiersCount = 5
    let amplifierControllerSoftware = self.inputCommaSeparatedNumbers
    var maxOutput = Int.min
    for configuration in self.permutations(of: Array(0..<amplifiersCount)) {
      var previousOutput = 0
      for amplifierIndex in 0..<amplifiersCount {
        var memory = amplifierControllerSoftware
        var address = 0
        let inputProvider = AmplifiersInputProvider(configuration: configuration[amplifierIndex], previousOutput: previousOutput)
        previousOutput = IntCode.executeProgram(
          memory: &memory,
          from: &address,
          inputProvider: inputProvider,
          stopOnWrite: true
        )!
      }

      maxOutput = max(maxOutput, previousOutput)
    }

    return maxOutput
  }

  func part2(_ input: String) -> Any {
    let amplifiersCount = 5
    let amplifierControllerSoftware = self.inputCommaSeparatedNumbers

    var maxOutput = Int.min
    for configuration in self.permutations(of: Array(5..<(5+amplifiersCount))) {
      var previousOutput: Int? = 0
      var memories = Array(repeating: amplifierControllerSoftware, count: amplifiersCount)
      var addresses = Array(repeating: 0, count: amplifiersCount)
      var inputProviders: [AmplifiersInputProvider] = []
      for amplifierIndex in 0..<amplifiersCount {
        inputProviders.append(AmplifiersInputProvider(configuration: configuration[amplifierIndex]))
      }
      var lastAmplifierOutput = Int.min

      while previousOutput != nil {
        for amplifierIndex in 0..<amplifiersCount {
          let inputProvider = inputProviders[amplifierIndex]
          inputProvider.previousOutput = previousOutput
          previousOutput = IntCode.executeProgram(
            memory: &memories[amplifierIndex],
            from: &addresses[amplifierIndex],
            inputProvider: inputProvider,
            stopOnWrite: true
          )
        }

        if let previousOutput = previousOutput {
          lastAmplifierOutput = previousOutput
        }
      }

      maxOutput = max(maxOutput, lastAmplifierOutput)
    }

    return maxOutput
  }

  private func permutations(of numbers: [Int], n: Int? = nil) -> [[Int]] {
    let n = n ?? numbers.count - 1
    guard n > 0 else { return [numbers] }

    var numbers = numbers
    var permutations: [[Int]] = []
    permutations += self.permutations(of: numbers, n: n - 1)
    for i in 0..<n {
      numbers.swapAt(i, n)
      permutations += self.permutations(of: numbers, n: n - 1)
      numbers.swapAt(i, n)
    }
    return permutations
  }

  class AmplifiersInputProvider: InputProvider {
    let configuration: Int
    var previousOutput: Int?
    private var isFirstNext = true

    init(configuration: Int, previousOutput: Int = 0) {
      self.configuration = configuration
      self.previousOutput = previousOutput
    }

    var next: Int {
      let returnValue = self.isFirstNext ? self.configuration : self.previousOutput
      isFirstNext = false
      return returnValue ?? 0
    }
  }
}

extension Day7 {
  var input: String {
    """
    3,8,1001,8,10,8,105,1,0,0,21,38,47,64,89,110,191,272,353,434,99999,3,9,101,4,9,9,102,3,9,9,101,5,9,9,4,9,99,3,9,1002,9,5,9,4,9,99,3,9,101,2,9,9,102,5,9,9,1001,9,5,9,4,9,99,3,9,1001,9,5,9,102,4,9,9,1001,9,5,9,1002,9,2,9,1001,9,3,9,4,9,99,3,9,102,2,9,9,101,4,9,9,1002,9,4,9,1001,9,4,9,4,9,99,3,9,101,1,9,9,4,9,3,9,101,1,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,101,2,9,9,4,9,3,9,101,1,9,9,4,9,3,9,1001,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,101,2,9,9,4,9,99,3,9,101,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,101,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,101,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,101,2,9,9,4,9,3,9,1001,9,2,9,4,9,3,9,102,2,9,9,4,9,99,3,9,1001,9,2,9,4,9,3,9,1001,9,2,9,4,9,3,9,101,1,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,1001,9,1,9,4,9,3,9,1002,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,101,1,9,9,4,9,3,9,101,1,9,9,4,9,99,3,9,102,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,1001,9,1,9,4,9,3,9,1002,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,1001,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,1002,9,2,9,4,9,99,3,9,101,1,9,9,4,9,3,9,102,2,9,9,4,9,3,9,1001,9,2,9,4,9,3,9,1001,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,1001,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,1002,9,2,9,4,9,99
    """
  }
}
