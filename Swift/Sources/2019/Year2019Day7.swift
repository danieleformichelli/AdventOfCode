// Created by Daniele Formichelli.

import Utils

/// https://adventofcode.com/2019/day/7
struct Year2019Day7: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    let amplifiersCount = 5
    let amplifierControllerSoftware = input.intCodeMemory
    var maxOutput = Int64.min
    for configuration in permutations(of: Array(0 ..< amplifiersCount)) {
      var previousOutput: Int64 = 0
      for amplifierIndex in 0 ..< amplifiersCount {
        var memory = amplifierControllerSoftware
        var address: Int64 = 0
        let configuration = Int64(configuration[amplifierIndex])
        let inputProvider = AmplifiersInputProvider(configuration: configuration, previousOutput: previousOutput)
        previousOutput = IntCode.executeProgram(
          memory: &memory,
          from: &address,
          stopOnWrite: true,
          input: { inputProvider.next }
        )!
      }

      maxOutput = max(maxOutput, previousOutput)
    }

    return maxOutput
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    let amplifiersCount = 5
    let amplifierControllerSoftware = input.intCodeMemory

    var maxOutput = Int64.min
    for configuration in permutations(of: Array(5 ..< 5 + amplifiersCount)) {
      var previousOutput: Int64? = 0
      var memories = Array(repeating: amplifierControllerSoftware, count: amplifiersCount)
      var addresses = Array(repeating: Int64(0), count: amplifiersCount)
      var inputProviders: [AmplifiersInputProvider] = []
      for amplifierIndex in 0 ..< amplifiersCount {
        inputProviders.append(AmplifiersInputProvider(configuration: Int64(configuration[amplifierIndex])))
      }
      var lastAmplifierOutput = Int64.min

      while previousOutput != nil {
        for amplifierIndex in 0 ..< amplifiersCount {
          let inputProvider = inputProviders[amplifierIndex]
          inputProvider.previousOutput = previousOutput
          previousOutput = IntCode.executeProgram(
            memory: &memories[amplifierIndex],
            from: &addresses[amplifierIndex],
            stopOnWrite: true,
            input: { inputProvider.next }
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
}

extension Year2019Day7 {
  private func permutations(of numbers: [Int], n: Int? = nil) -> [[Int]] {
    let n = n ?? numbers.count - 1
    guard n > 0 else { return [numbers] }

    var numbers = numbers
    var permutations: [[Int]] = []
    permutations += self.permutations(of: numbers, n: n - 1)
    for i in 0 ..< n {
      numbers.swapAt(i, n)
      permutations += self.permutations(of: numbers, n: n - 1)
      numbers.swapAt(i, n)
    }
    return permutations
  }

  class AmplifiersInputProvider {
    let configuration: Int64
    var previousOutput: Int64?
    private var isFirstNext = true

    init(configuration: Int64, previousOutput: Int64 = 0) {
      self.configuration = configuration
      self.previousOutput = previousOutput
    }

    var next: Int64 {
      let returnValue = self.isFirstNext ? self.configuration : self.previousOutput
      self.isFirstNext = false
      return returnValue ?? 0
    }
  }
}
