//
//  Year2020Day12.swift
//  AdventOfCode2020
//
//  Created by Daniele Formichelli on 12/12/2020.
//  Copyright © 2020 Daniele Formichelli. All rights reserved.
//

import Utils

/// https://adventofcode.com/2020/day/12
public struct Year2020Day12: DayBase {
  public func part1(_ input: String) -> CustomDebugStringConvertible {
    var position: Point = .zero
    var direction: Direction = .right
    for navigationInstruction in input.navigationInstructions {
      switch navigationInstruction {
      case .move(let moveDirection, let distance):
        position = .init(x: position.x + distance * moveDirection.dx, y: position.y + distance * moveDirection.dy)
      case .moveForward(let distance):
        position = .init(x: position.x + distance * direction.dx, y: position.y + distance * direction.dy)
      case .rotateRight(let angle):
        direction = direction.rotateRight(by: angle)
      case .rotateLeft(let angle):
        direction = direction.rotateLeft(by: angle)
      }
    }
    return position.manhattanDistance(from: .zero)
  }

  public func part2(_ input: String) -> CustomDebugStringConvertible {
    var position = Point(x: 0, y: 0)
    var waypoint = Point(x: 10, y: -1)
    for navigationInstruction in input.navigationInstructions {
      switch navigationInstruction {
      case .move(let moveDirection, let distance):
        waypoint = .init(x: waypoint.x + distance * moveDirection.dx, y: waypoint.y + distance * -moveDirection.dy)
      case .moveForward(let distance):
        position = .init(x: position.x + distance * waypoint.x, y: position.y + distance * waypoint.y)
      case .rotateRight(let angle):
        waypoint = waypoint.rotateRight(by: angle)
      case .rotateLeft(let angle):
        waypoint = waypoint.rotateLeft(by: angle)
      }
    }
    return position.manhattanDistance(from: .zero)
  }
}

extension Year2020Day12 {
  fileprivate enum NavigationInstruction {
    case move(direction: Direction, distance: Int)
    case moveForward(distance: Int)
    case rotateRight(by: Int)
    case rotateLeft(by: Int)
  }
}

extension Direction {
  fileprivate func rotateRight(by angle: Int) -> Self {
    var direction = self
    (1 ... angle / 90).forEach { _ in
      direction = direction.turnRight
    }
    return direction
  }

  fileprivate func rotateLeft(by angle: Int) -> Self {
    return self.rotateRight(by: 360 - angle)
  }
}

extension Point {
  fileprivate var turnRight: Self {
    return .init(x: -y, y: x)
  }

  fileprivate func rotateRight(by angle: Int) -> Self {
    var direction = self
    (1 ... angle / 90).forEach { _ in
      direction = direction.turnRight
    }
    return direction
  }

  fileprivate func rotateLeft(by angle: Int) -> Self {
    return self.rotateRight(by: 360 - angle)
  }
}

extension String {
  fileprivate var navigationInstructions: [Year2020Day12.NavigationInstruction] {
    return self.lines.map { line in
      let value = Int(line.dropFirst())!
      switch line.first {
      case "N":
        return .move(direction: .up, distance: value)
      case "S":
        return .move(direction: .down, distance: value)
      case "E":
        return .move(direction: .right, distance: value)
      case "W":
        return .move(direction: .left, distance: value)
      case "F":
        return .moveForward(distance: value)
      case "R":
        return .rotateRight(by: value)
      case "L":
        return .rotateLeft(by: value)
      default:
        fatalError()
      }
    }
  }
}
