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
    let cups = self.run(cups: input.cups, moves: 100).asArray
    let indexOfOne = cups.firstIndex(of: 1)!
    return (cups[(indexOfOne + 1)...] + cups[..<indexOfOne]).map(String.init).joined()
  }

  public func part2(_ input: String) -> CustomDebugStringConvertible {
    let firstCups = input.cups
    let allCups = (1 ... 1000000).map { index in index <= firstCups.count ? firstCups[index - 1] : index }
    var cups = self.run(cups: allCups, moves: 10000000)
    while cups.value != 1 {
      cups = cups.next!
    }
    return cups.next!.value * cups.next!.next!.value
  }

  private func run(cups: [Int], moves: Int) -> ListNode<Int> {
    let maxCup = cups.count
    var currentCup = cups.toList!
    var hash: [Int: ListNode<Int>] = [:]
    var head: ListNode<Int>? = currentCup
    var tail: ListNode<Int>?
    repeat {
      tail = head
      hash[head!.value] = head
      head = head?.next
    } while head != nil
    tail?.next = currentCup

    (1 ... moves).forEach { _ in
      let firstPicked = currentCup.next!
      let lastPicked = currentCup.next!.next!.next!
      let nextCurrent = lastPicked.next!
      var destinationCup = currentCup.value
      repeat {
        destinationCup = (destinationCup - 2 + maxCup) % maxCup + 1
      } while currentCup.next!.value == destinationCup || currentCup.next!.next!.value == destinationCup || currentCup.next!.next!.next!.value == destinationCup

      // Remove picked ones
      currentCup.next = nextCurrent
      nextCurrent.prev = currentCup

      // …until the destination, then the picked ones
      let destinationCupNode = hash[destinationCup]!
      lastPicked.next = destinationCupNode.next
      destinationCupNode.next?.prev = lastPicked.next
      destinationCupNode.next = firstPicked
      firstPicked.prev = destinationCupNode

      // Move the current cup
      currentCup = nextCurrent
    }

    // break the circle
    currentCup.prev?.next = nil

    return currentCup
  }
}

extension String {
  fileprivate var cups: [Int] {
    return self.compactMap { Int(String($0)) }
  }
}
