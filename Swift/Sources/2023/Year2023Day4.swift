// Created by Daniele Formichelli.

import Utils

/// https://adventofcode.com/2023/day/4
struct Year2023Day4: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    return input.cards.map { card in
      var value = 0
      for winningNumber in card.winning {
        if (card.mine.contains(winningNumber)) {
          if value > 0 {
            value *= 2
          } else {
            value = 1
          }
        }
      }
      return value
    }.sum as Int
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    var scratchpads: [Int: Int] = [:]
    let cards = input.cards
    scratchpads[cards.count - 1] = 1
    cards.enumerated().dropLast().forEach { index, card in
      let matches = card.winning.filter { card.mine.contains($0) }.count
      scratchpads[index] = (scratchpads[index] ?? 0) + 1
      if matches > 0 {
        for i in index + 1 ..< min(index + 1 + matches, cards.count) {
          scratchpads[i] = (scratchpads[i] ?? 0) + scratchpads[index]!
        }
      }
    }
    return scratchpads.values.sum
  }
}

extension String {
  fileprivate var cards: [(winning: Set<Int>, mine: Set<Int>)] {
    return self.lines.map { line in
      let split = line.components(separatedBy: ": ")
      let numbersSplit = split[1].components(separatedBy: " | ")
      let winning = numbersSplit[0].components(separatedBy: " ").filter { !$0.isEmpty }.map { Int($0)! }.asSet
      let mine = numbersSplit[1].components(separatedBy: " ").filter { !$0.isEmpty }.map { Int($0)! }.asSet
      return (winning: winning, mine: mine)
    }
  }
}
