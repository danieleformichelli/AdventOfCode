//
//  Year2019Day16.swift
//  AdventOfCode2019
//
//  Created by Daniele Formichelli on 16/12/2019.
//  Copyright © 2019 Daniele Formichelli. All rights reserved.
//

import Utils

/// https://adventofcode.com/2019/day/16
struct Year2019Day16: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    let basePattern = [0, 1, 0, -1]
    let numbers = input.numbers
    var signal = numbers
    for _ in 1 ... 100 {
      signal = (1 ... numbers.count).map { position in
        let sum = signal.enumerated()
          .map { index, number -> Int in
            let multiplierIndex = ((index + 1) / position) % basePattern.count
            return number * basePattern[multiplierIndex]
          }
          .sum
        return abs(sum) % 10
      }
    }
    return signal.dropLast(signal.count - 8).map { String($0) }.joined(separator: "")
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    let signal = Array((1 ... 10000).map { _ in input.numbers }.joined())
    let toBeDropped = Int(signal.dropLast(signal.count - 7).map { String($0) }.joined(separator: ""))!
    if toBeDropped < signal.count / 2 {
      fatalError("This solution only works if the requested string is in the last half of the signal")
    }

    var interestingIndexes = Array(signal.dropFirst(toBeDropped))
    for _ in 1 ... 100 {
      var remainingSumFromBack = 0
      for index in stride(from: interestingIndexes.count - 1, through: 0, by: -1) {
        remainingSumFromBack = (remainingSumFromBack + interestingIndexes[index]) % 10
        interestingIndexes[index] = abs(remainingSumFromBack)
      }
    }

    return interestingIndexes.dropLast(interestingIndexes.count - 8).map { String($0) }.joined(separator: "")
  }
}

private extension String {
  var numbers: [Int] {
    map { Int(String($0))! }
  }
}

extension Year2019Day16 {
  var input: String {
    """
    59709511599794439805414014219880358445064269099345553494818286560304063399998657801629526113732466767578373307474609375929817361595469200826872565688108197109235040815426214109531925822745223338550232315662686923864318114370485155264844201080947518854684797571383091421294624331652208294087891792537136754322020911070917298783639755047408644387571604201164859259810557018398847239752708232169701196560341721916475238073458804201344527868552819678854931434638430059601039507016639454054034562680193879342212848230089775870308946301489595646123293699890239353150457214490749319019572887046296522891429720825181513685763060659768372996371503017206185697
    """
  }
}
