// Created by Daniele Formichelli.

import Foundation
import Utils

/// https://adventofcode.com/2022/day/5
struct Year2022Day5: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    var (positions, moves) = input.cratesInfo
    for (count, from, to) in moves {
      for _ in 0 ..< count {
        let element = positions[from]!.removeLast()
        positions[to]!.append(element)
      }
    }
    return positions
      .sorted { $0.key < $1.key }
      .map { String($0.value.last!) }
      .joined(separator: "")
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    var (positions, moves) = input.cratesInfo
    for (count, from, to) in moves {
      var movedStack: [Character] = []
      for _ in 0 ..< count {
        let element = positions[from]!.removeLast()
        movedStack.append(element)
      }
      positions[to]!.append(contentsOf: movedStack.reversed())
    }
    return positions
      .sorted { $0.key < $1.key }
      .map { String($0.value.last!) }
      .joined(separator: "")
  }
}

extension String {
  var cratesInfo: (positions: [Int: [Character]], moves: [(Int, Int, Int)]) {
    let split = components(separatedBy: "\n\n")
    let positions: [Int: [Character]] = split[0].components(separatedBy: "\n").dropLast().reversed().reduce(into: [:]) { result, line in
      for i in stride(from: 1, to: line.count, by: 4) {
        let stackIndex = 1 + i / 4
        let element = line[line.index(line.startIndex, offsetBy: i)]
        if element != " " {
          result[stackIndex, default: []].append(element)
        }
      }
    }

    let movesRegex = try! NSRegularExpression(pattern: "^move (\\d+) from (\\d+) to (\\d+)")
    let moves = split[1].components(separatedBy: "\n").compactMap { line -> (Int, Int, Int)? in
      guard let match = movesRegex.firstMatch(in: line, range: NSRange(location: 0, length: line.count)),
            let countRange = Range(match.range(at: 1), in: line),
            let count = Int(line[countRange]),
            let fromRange = Range(match.range(at: 2), in: line),
            let from = Int(line[fromRange]),
            let toRange = Range(match.range(at: 3), in: line),
            let to = Int(line[toRange])
      else {
        return nil
      }
      return (count, from, to)
    }

    return (positions: positions, moves: moves)
  }
}
