// Created by Daniele Formichelli.

import Utils

/// https://adventofcode.com/2023/day/8
struct Year2023Day8: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    return Self.solveSingle(from: "AAA", condition: { $0 == "ZZZ" }, instructions: input.instructions)
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    let instructions = input.instructions
    let current = instructions.nodes.keys.filter { $0.hasSuffix("A") }
    let firstLoop = current.map {
      return Self.solveSingle(from: $0, condition: { $0.hasSuffix("Z") }, instructions: instructions)
    }
    return Utils.lcm(firstLoop)
  }
  
  static func solveSingle(from: String, condition: (String) -> Bool, instructions: Instructions) -> Int {
    var current = from
    var steps = 0
    while !condition(current) {
      switch instructions.directions[steps % instructions.directions.count] {
      case .left:
        current = instructions.nodes[current]!.left
      case .right:
        current = instructions.nodes[current]!.right
      }
      steps += 1
    }
    return steps
  }
}

struct Instructions {
  enum Direction {
    case left
    case right
  }
  let directions: [Direction]
  let nodes: [String: (left: String, right: String)]
}

extension String {
  fileprivate var instructions: Instructions {
    let split = self.groupedLines
    let directions = split[0][0].map { char in
      switch char {
      case "L":
        return Instructions.Direction.left
      case "R":
        return Instructions.Direction.right
      default:
        fatalError()
      }
    }
    let nodes = Dictionary(uniqueKeysWithValues: split[1].map { node in
      let split = node.components(separatedBy: " = (")
      let from = split[0]
      let destinationSplit = split[1].components(separatedBy: ", ")
      return (from, (left: destinationSplit[0], right: String(destinationSplit[1].dropLast())))
    })
    return .init(directions: directions, nodes: nodes)
  }
}
