//
//  Year2020Day22.swift
//  AdventOfCode2020
//
//  Created by Daniele Formichelli on 22/12/2020.
//  Copyright © 2020 Daniele Formichelli. All rights reserved.
//

import Foundation
import Utils

/// https://adventofcode.com/2020/day/22
public struct Year2020Day22: DayBase {
  public func part1(_ input: String) -> CustomDebugStringConvertible {
    let round = input.decks
    var deck1 = round.deck1
    var deck2 = round.deck2

    while !deck1.isEmpty && !deck2.isEmpty {
      let card1 = deck1.removeFirst()
      let card2 = deck2.removeFirst()

      if card1 > card2 {
        deck1 += [card1, card2]
      } else {
        deck2 += [card2, card1]
      }
    }

    let winningDeck = deck1.isEmpty ? deck2 : deck1
    return winningDeck.score
  }

  public func part2(_ input: String) -> CustomDebugStringConvertible {
    let round = input.decks
    let winningDeck = self.recursiveCombat(deck1: round.deck1, deck2: round.deck2).1
    return winningDeck.score
  }

  private func recursiveCombat(deck1: [Int], deck2: [Int]) -> (Bool, [Int]) {
    var previousRounds: Set<Round> = []
    var deck1 = deck1
    var deck2 = deck2
    while !deck1.isEmpty && !deck2.isEmpty {
      let round = Round(deck1: deck1, deck2: deck2)
      guard !previousRounds.contains(round) else { break }
      previousRounds.insert(round)

      let card1 = deck1.removeFirst()
      let card2 = deck2.removeFirst()

      let oneWins: Bool
      if deck1.count >= card1 && deck2.count >= card2 {
        oneWins = recursiveCombat(deck1: deck1.prefix(card1).asArray, deck2: deck2.prefix(card2).asArray).0
      } else {
        oneWins = card1 > card2
      }

      if oneWins {
        deck1 += [card1, card2]
      } else {
        deck2 += [card2, card1]
      }
    }

    if deck1.isEmpty {
      return (false, deck2)
    } else {
      return (true, deck1)
    }
  }
}

extension Year2020Day22 {
  fileprivate struct Round: Hashable {
    let deck1: [Int]
    let deck2: [Int]
  }
}

extension String {
  fileprivate var decks: Year2020Day22.Round {
    let decks = self.dropFirst(10).components(separatedBy: "\n\nPlayer 2:\n").map { $0.numbers }
    return Year2020Day22.Round(deck1: decks[0], deck2: decks[1])
  }
}

extension Array where Element == Int {
  var score: Int {
    return self.reversed().enumerated().map { index, value in (index + 1) * value }.sum
  }
}
