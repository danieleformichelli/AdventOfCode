// Created by Daniele Formichelli.

import Utils

/// https://adventofcode.com/2021/day/4
struct Year2021Day4: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    return self.resolve(input, last: false)
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    return self.resolve(input, last: true)
  }

  fileprivate func resolve(_ input: String, last: Bool) -> CustomDebugStringConvertible {
    let parsedInput = input.parsedInput
    var marked: Set<Int> = []
    var winnerBoards: Set<Int> = []
    for number in parsedInput.numbers {
      marked.insert(number)
      for boardPosition in parsedInput.numberToBoardPositions[number] ?? [] {
        guard !winnerBoards.contains(boardPosition.boardIndex) else {
          continue
        }
        let board = parsedInput.boards[boardPosition.boardIndex]

        let rowDone = board.numbers[boardPosition.position.x].allSatisfy { marked.contains($0) }
        let colDone = (0 ..< board.numbers.count)
          .map { board.numbers[$0][boardPosition.position.y]}
          .allSatisfy { marked.contains($0) }
        if rowDone || colDone {
          winnerBoards.insert(boardPosition.boardIndex)

          let isResult = !last || last && winnerBoards.count == parsedInput.boards.count
          if isResult {
            let unmarkedNumbersSum = board.numbers
              .flatMap {
                $0.filter { !marked.contains($0) }
              }
              .sum
            return number * unmarkedNumbersSum
            }
        }
      }
    }

    fatalError()
  }
}

extension Year2021Day4 {
  fileprivate struct Input {
    fileprivate struct BoardPosition {
      let boardIndex: Int
      let position: Point
    }

    fileprivate struct Board {
      let numbers: [[Int]]
    }

    let numbers: [Int]
    let boards: [Board]
    let numberToBoardPositions: [Int: [BoardPosition]]
  }
}

extension String {
  fileprivate var parsedInput: Year2021Day4.Input {
    let lines = self.lines + [""]
    let numbers = lines[0].commaSeparatedNumbers

    var boards: [Year2021Day4.Input.Board] = []
    var currentBoardNumbers: [[Int]] = []
    var numberToBoardPositions: [Int: [Year2021Day4.Input.BoardPosition]] = [:]
    lines.dropFirst(2).forEach { line in
      guard !line.isEmpty else {
        boards.append(.init(numbers: currentBoardNumbers))
        currentBoardNumbers = []
        return
      }
      let numbers = line.components(separatedBy: " ").compactMap { Int($0) }
      numbers.enumerated().forEach { col, number in
        var current = numberToBoardPositions[number] ?? []
        current.append(.init(boardIndex: boards.count, position: .init(x: currentBoardNumbers.count, y: col)))
        numberToBoardPositions[number] = current
      }
      currentBoardNumbers.append(numbers)
    }

    return .init(numbers: numbers, boards: boards, numberToBoardPositions: numberToBoardPositions)
  }
}
