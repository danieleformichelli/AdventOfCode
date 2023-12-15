// Created by Daniele Formichelli.

import Utils

/// https://adventofcode.com/2023/day/15
struct Year2023Day15: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    return input.components(separatedBy: ",").map { Self.hash($0) }.sum as Int
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    var boxes: [[(label: String, focal: Int)]] = (0 ..< 256).map { _ in [] }
    for step in input.steps {
      switch step {
      case let .add(label, focal):
        let boxIndex = Self.hash(label)
        if let lensIndex = boxes[boxIndex].firstIndex(where: { $0.label == label }) {
          boxes[boxIndex][lensIndex] = (label: label, focal: focal)
        } else {
          boxes[boxIndex].append((label: label, focal: focal))
        }
      case let .remove(label):
        let boxIndex = Self.hash(label)
        if let lensIndex = boxes[boxIndex].firstIndex(where: { $0.label == label }) {
          boxes[boxIndex].remove(at: lensIndex)
        }
      }
    }
    return boxes.enumerated().map { boxIndex, box in
      return box.enumerated().map { lensIndex, lens in
        return (boxIndex + 1) * (lensIndex + 1) * lens.focal
      }.sum
    }.sum as Int
  }
  
  static func hash(_ label: String) -> Int {
    var hash = 0
    for char in label {
      hash += Int(char.asciiValue!)
      hash *= 17
      hash %= 256
    }
    return hash
  }
}

enum Step {
  case add(String, Int)
  case remove(String)
}

extension String {
  fileprivate var steps: [Step] {
    let steps = self.components(separatedBy: ",")
    return steps.map { step in
      let splitByEqual = step.components(separatedBy: "=")
      if splitByEqual.count == 2 {
        return .add(splitByEqual[0], Int(splitByEqual[1])!)
      } else {
        return .remove(String(step.dropLast()))
      }
    }
    
  }
}
