//
//  Year2020Day23.swift
//  AdventOfCode2020
//
//  Created by Daniele Formichelli on 23/12/2020.
//  Copyright © 2020 Daniele Formichelli. All rights reserved.
//

import Foundation
import Utils

/// https://adventofcode.com/2020/day/23
public struct Year2020Day23: DayBase {
  public func part1(_ input: String) -> CustomDebugStringConvertible {
    let cups = self.run(cups: input.cups, moves: 100)
    let indexOfOne = cups.firstIndex(of: 1)!
    return (cups[(indexOfOne + 1)...] + cups[..<indexOfOne]).map(String.init).joined()
  }

  public func part2(_ input: String) -> CustomDebugStringConvertible {
    let firstCups = input.cups
    let allCups = (1 ... 1000000).map { index in index <= firstCups.count ? firstCups[index - 1] : index }
    let cups = self.run(cups: allCups, moves: 10000000)
    let indexOfOne = cups.firstIndex(of: 1)!
    return cups[indexOfOne + 1] * cups[indexOfOne + 2]
  }

  private func run(cups: [Int], moves: Int) -> [Int] {
    var cache: [[Int]: Int] = [:]
    var cups = cups
    let maxCup = cups.count
    (1 ... moves).forEach { index in
      guard cache[cups] == nil else {
        // TODO handle this
        fatalError()
      }
      cache[cups] = index - 1
      let currentCup = cups[0]
      let picked = cups[1...3]
      let remaining = cups[4...]
      var destinationCup = currentCup
      repeat {
        destinationCup = (destinationCup - 2 + maxCup) % maxCup + 1
      } while picked.contains(destinationCup)
      let destinationIndex = remaining.firstIndex(of: destinationCup)!
      cups = remaining[..<destinationIndex] + [destinationCup] + picked + remaining[(destinationIndex + 1)...] + [currentCup]
    }
    return cups
  }
}

extension String {
  var cups: [Int] {
    return self.compactMap { Int(String($0)) }
  }
}
