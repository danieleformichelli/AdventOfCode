//
//  Year2019Day19.swift
//  AdventOfCode2019
//
//  Created by Daniele Formichelli on 19/12/2019.
//  Copyright © 2019 Daniele Formichelli. All rights reserved.
//

import Utils

/// https://adventofcode.com/2019/day/19
struct Year2019Day19: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    var cache: [Point: Element] = [:]
    var pointsToExplore: Set<Point> = []
    for x in 0 ..< 100 {
      for y in 0 ..< 100 {
        pointsToExplore.insert(Point(x: x, y: y))
      }
    }

    var map: [Point: Element] = [:]
    while !pointsToExplore.isEmpty {
      let currentPointToExplore = pointsToExplore.removeFirst()
      map[currentPointToExplore] = self.getElement(for: input, at: currentPointToExplore, cache: &cache)
    }

    return map.print(invertedY: true, clearElement: .stationary)
//    return map.values.filter { $0 == .pulled }.count
  }

  func part2(_: String) -> CustomDebugStringConvertible {
    ""
  }

  private func getElement(for input: String, at point: Point, cache: inout [Point: Element]) -> Element {
    if let element = cache[point] {
      return element
    }

    var memory = input.intCodeMemory
    var address: Int64 = 0
    var isFirstInput = true
    while address >= 0 {
      let output = IntCode.executeProgram(memory: &memory, from: &address, stopOnWrite: true, input: {
        if isFirstInput {
          isFirstInput = false
          return Int64(point.x)
        } else {
          return Int64(point.y)
        }
      })
      if
        let output = output,
        let element = Element(rawValue: output)
      {
        cache[point] = element
        return element
      }
    }

    fatalError("Can't find element for \(point)")
  }
}

private enum Element: Int64, MapElement {
  case stationary = 0
  case pulled = 1

  var representation: String {
    switch self {
    case .stationary:
      return "⬛️"
    case .pulled:
      return "🌬"
    }
  }
}

extension Year2019Day19 {
  var input: String {
    """
    109,424,203,1,21101,11,0,0,1105,1,282,21101,0,18,0,1106,0,259,1202,1,1,221,203,1,21101,0,31,0,1105,1,282,21102,1,38,0,1106,0,259,20101,0,23,2,22102,1,1,3,21101,1,0,1,21101,0,57,0,1106,0,303,1202,1,1,222,21002,221,1,3,21001,221,0,2,21102,1,259,1,21101,80,0,0,1105,1,225,21102,1,117,2,21102,1,91,0,1105,1,303,1202,1,1,223,20102,1,222,4,21101,0,259,3,21101,0,225,2,21101,225,0,1,21101,118,0,0,1105,1,225,21001,222,0,3,21101,20,0,2,21102,1,133,0,1105,1,303,21202,1,-1,1,22001,223,1,1,21101,0,148,0,1106,0,259,2101,0,1,223,20102,1,221,4,21001,222,0,3,21101,0,16,2,1001,132,-2,224,1002,224,2,224,1001,224,3,224,1002,132,-1,132,1,224,132,224,21001,224,1,1,21102,195,1,0,105,1,108,20207,1,223,2,21002,23,1,1,21102,-1,1,3,21101,0,214,0,1105,1,303,22101,1,1,1,204,1,99,0,0,0,0,109,5,1201,-4,0,249,22102,1,-3,1,22101,0,-2,2,21202,-1,1,3,21102,1,250,0,1106,0,225,22102,1,1,-4,109,-5,2105,1,0,109,3,22107,0,-2,-1,21202,-1,2,-1,21201,-1,-1,-1,22202,-1,-2,-2,109,-3,2106,0,0,109,3,21207,-2,0,-1,1206,-1,294,104,0,99,21202,-2,1,-2,109,-3,2105,1,0,109,5,22207,-3,-4,-1,1206,-1,346,22201,-4,-3,-4,21202,-3,-1,-1,22201,-4,-1,2,21202,2,-1,-1,22201,-4,-1,1,21201,-2,0,3,21101,343,0,0,1105,1,303,1105,1,415,22207,-2,-3,-1,1206,-1,387,22201,-3,-2,-3,21202,-2,-1,-1,22201,-3,-1,3,21202,3,-1,-1,22201,-3,-1,2,21201,-4,0,1,21101,0,384,0,1105,1,303,1105,1,415,21202,-4,-1,-4,22201,-4,-3,-4,22202,-3,-2,-2,22202,-2,-4,-4,22202,-3,-2,-3,21202,-4,-1,-2,22201,-3,-2,1,22101,0,1,-4,109,-5,2105,1,0
    """
  }
}
