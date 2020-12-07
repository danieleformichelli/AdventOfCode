//
//  Year2019Day11.swift
//  AdventOfCode2019
//
//  Created by Daniele Formichelli on 11/12/2019.
//  Copyright © 2019 Daniele Formichelli. All rights reserved.
//

import Utils

/// https://adventofcode.com/2019/day/11
struct Year2019Day11: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    self.paint(input, startingColor: .black).count
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    self.paint(input, startingColor: .white).print(invertedY: false, clearElement: .black)
  }

  private func paint(_ input: String, startingColor: Color) -> [Point: Color] {
    var memory = input.intCodeMemory
    var currentPosition: Point = .zero
    var currentDirection: Direction = .up
    var paintedPanels: [Point: Color] = [:]
    paintedPanels[currentPosition] = startingColor

    var address: Int64 = 0
    while address >= 0 {
      let currentColor = paintedPanels[currentPosition] ?? .black
      let paintColor = IntCode.executeProgram(memory: &memory, from: &address, stopOnWrite: true, input: { currentColor.rawValue })
      if let paintColor = paintColor {
        paintedPanels[currentPosition] = Color(rawValue: paintColor)
      }
      let turnDirection = IntCode.executeProgram(memory: &memory, from: &address, stopOnWrite: true, input: { currentColor.rawValue })
      switch turnDirection {
      case 0:
        currentDirection = currentDirection.turnLeft
      case 1:
        currentDirection = currentDirection.turnRight
      default:
        break
      }

      currentPosition = Point(x: currentPosition.x + currentDirection.dx, y: currentPosition.y + currentDirection.dy)
    }

    return paintedPanels
  }
}

private extension Year2019Day11 {
  enum Color: Int64, MapElement {
    case black = 0
    case white = 1

    var representation: String {
      switch self {
      case .black:
        return "⬛️"
      case .white:
        return "⬜️"
      }
    }
  }
}
