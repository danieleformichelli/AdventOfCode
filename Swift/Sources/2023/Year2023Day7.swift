// Created by Daniele Formichelli.

import Utils

/// https://adventofcode.com/2023/day/7
struct Year2023Day7: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    return Self.solve(input: input, useJokers: false)
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    return Self.solve(input: input, useJokers: true)
  }
  
  static func solve(input: String, useJokers: Bool) -> Int {
    return input.handsWithBid(useJokers: useJokers)
      .sorted { lhs, rhs in
        if (lhs.score != rhs.score) {
          return lhs.score < rhs.score
        }
        for i in 0 ..< lhs.hand.count {
          if lhs.hand[i] != rhs.hand[i] {
            return lhs.hand[i] < rhs.hand[i]
          }
        }
        fatalError()
      }
      .enumerated().map { index, handWithBid in
        return (index + 1) * handWithBid.bid
      }
      .sum
  }
}

extension String {
  fileprivate func handsWithBid(useJokers: Bool) -> [(hand: [Int], score: Int, bid: Int)] {
    self.lines.map { line in
      let split = line.components(separatedBy: " ")
      let hand = split[0].map { card in
        if let number = Int(String(card)) {
          return number
        } else {
          switch card {
          case "T":
            return 10
          case "J":
            return useJokers ? 0 : 11
          case "Q":
            return 12
          case "K":
            return 13
          case "A":
            return 14
          default:
            fatalError()
          }
        }
      }
      return (hand: hand, score: Self.score(hand), bid: Int(split[1])!)
    }
  }
  
  static func score(_ hand: [Int]) -> Int {
    var jokers = 0
    var grouped: [Int: Int] = [:]
    for card in hand {
      if card == 0 {
        jokers += 1
      }
      grouped[card] = (grouped[card] ?? 0) + 1
    }
    switch grouped.count {
    case 1:
      // five of a kind
      return 7
    case 2:
      if jokers > 0 {
        // five of a kind
        return 7
      } else {
        if grouped.values.max() == 4 {
          // four of a kind
          return 6
        } else {
          // full house or
          return 5
        }
      }
    case 3:
      if grouped.values.max() == 3 {
        // three of a kind or four of a kind with joker
        return jokers > 0 ? 6 : 4
      } else {
        if jokers > 0 {
          switch jokers {
          case 1:
            // full house
            return 5
          case 2:
            // four of a kind
            return 6
          default:
            fatalError()
          }
        } else {
          // two pair
          return 3
        }
      }
    case 4:
      // pair or three of a kind if with joker
      return jokers > 0 ? 4 : 2
    case 5:
      // high card or pair if with joker
      return jokers > 0 ? 2 : 1
    default:
      fatalError()
    }
  }
}
