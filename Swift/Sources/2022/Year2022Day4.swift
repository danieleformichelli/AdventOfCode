// Created by Daniele Formichelli.

import Utils

/// https://adventofcode.com/2022/day/4
struct Year2022Day4: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    let pairs = input.pairs
    return pairs
      .filter { first, second in
        (first.from <= second.from && first.to >= second.to) ||
        (second.from <= first.from && second.to >= first.to)
      }
      .count
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    let pairs = input.pairs
    return pairs
      .filter { first, second in
        (first.from <= second.to && first.to >= second.from) ||
        (second.from <= first.to && second.to >= first.from)
      }
      .count
  }
}

extension String {
  var pairs: [((from: Int, to: Int), (from: Int, to: Int))] {
    return self
      .components(separatedBy: "\n")
      .map { line in
        let pair = line
          .components(separatedBy: ",")
          .map {
            let range = $0.split(separator: "-")
            return (from: Int(range[0])!, to: Int(range[1])!)
          }
        return (pair[0], pair[1])
      }
  }
}
