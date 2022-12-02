// Created by Daniele Formichelli.

import Utils

/// https://adventofcode.com/2022/day/1
struct Year2022Day2: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    let rounds: [(opponent: Kind, me: Kind)] = input.lines
      .map { line in
        let split = line.split(separator: " ")
        let opponent: Kind
        switch split[0] {
        case "A":
          opponent = .rock
        case "B":
          opponent = .paper
        case "C":
          opponent = .scissor
        default:
          fatalError("Invalid value: \(split[0])")
        }
        let me: Kind
        switch split[1] {
        case "X":
          me = .rock
        case "Y":
          me = .paper
        case "Z":
          me = .scissor
        default:
          fatalError("Invalid value: \(split[1])")
        }
        return (opponent: opponent, me: me)
      }
    let score = rounds
      .map {
        let result = $0.me.result(against: $0.opponent)
        return $0.me.score + result.score
      }
      .sum
    return score
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    let rounds: [(opponent: Kind, result: Result)] = input.lines
      .map { line in
        let split = line.split(separator: " ")
        let opponent: Kind
        switch split[0] {
        case "A":
          opponent = .rock
        case "B":
          opponent = .paper
        case "C":
          opponent = .scissor
        default:
          fatalError("Invalid value: \(split[0])")
        }
        let result: Result
        switch split[1] {
        case "X":
          result = .lose
        case "Y":
          result = .draw
        case "Z":
          result = .win
        default:
          fatalError("Invalid value: \(split[1])")
        }
        return (opponent: opponent, result: result)
      }
    let score = rounds
      .map {
        let me = $0.opponent.kind(for: $0.result)
        return me.score + $0.result.score
      }
      .sum
    return score
  }
}

enum Result {
  case win
  case draw
  case lose

  var score: Int {
    switch self {
    case .win:
      return 6
    case .draw:
      return 3
    case .lose:
      return 0
    }
  }
}
enum Kind {
  case paper
  case rock
  case scissor


  var score: Int {
    switch self {
    case .paper:
      return 2
    case .rock:
      return 1
    case .scissor:
      return 3
    }
  }

  func kind(for result: Result) -> Self {
    switch (self, result) {
    case (.paper, .draw), (.rock, .win), (.scissor, .lose):
      return .paper
    case (.paper, .lose), (.rock, .draw), (.scissor, .win):
      return .rock
    case (.paper, .win), (.rock, .lose), (.scissor, .draw):
      return .scissor
    }
  }

  func result(against other: Self) -> Result {
    switch (self, other) {
    case (.paper, .rock), (.rock, .scissor), (.scissor, .paper):
      return .win
    case (.paper, .paper), (.rock, .rock), (.scissor, .scissor):
      return .draw
    case (.paper, .scissor), (.rock, .paper), (.scissor, .rock):
      return .lose
    }
  }
}
