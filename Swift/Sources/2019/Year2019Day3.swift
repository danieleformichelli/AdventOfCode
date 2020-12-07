//
//  Year2019Day3.swift
//  AdventOfCode2019
//
//  Created by Daniele Formichelli on 03/12/2019.
//  Copyright © 2019 Daniele Formichelli. All rights reserved.
//

import Utils

/// https://adventofcode.com/2019/day/3
struct Year2019Day3: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    let wiresSegments = input.wiresSegments
    var path: [Point: Int] = [:]
    let origin: Point = .zero
    var nearestIntersectionDistance: Int = .max
    for (wireIndex, wireSegments) in wiresSegments.enumerated() {
      var currentPosition = origin

      for segment in wireSegments {
        currentPosition = segment.move(from: currentPosition) { position in
          let oldValue = path.updateValue(wireIndex, forKey: position)
          if let oldValue = oldValue, oldValue != wireIndex {
            let intersectionDistance = position.manhattanDistance(from: origin)
            nearestIntersectionDistance = min(nearestIntersectionDistance, intersectionDistance)
          }
        }
      }
    }

    return nearestIntersectionDistance
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    let wiresSegments = input.wiresSegments
    var distanceTo: [Point: (wireIndex: Int, distance: Int)] = [:]
    let origin: Point = .zero
    var nearestIntersectionDistance: Int = .max
    for (wireIndex, wireSegments) in wiresSegments.enumerated() {
      var currentPosition = origin
      var currentDistance = 0

      for segment in wireSegments {
        currentPosition = segment.move(from: currentPosition) { position in
          currentDistance += 1
          let oldValue = distanceTo.updateValue((wireIndex: wireIndex, distance: currentDistance), forKey: position)
          if let oldValue = oldValue, oldValue.wireIndex != wireIndex {
            let otherWireDistance = oldValue.distance
            nearestIntersectionDistance = min(nearestIntersectionDistance, otherWireDistance + currentDistance)
          }
        }
      }
    }

    return nearestIntersectionDistance
  }
}

private extension Year2019Day3 {
  struct Segment {
    let direction: Direction
    let length: Int

    init(string: String) {
      self.direction = Direction(rawValue: String(string.prefix(1)))!
      self.length = Int(string.dropFirst())!
    }

    func move(from: Point, action: (Point) -> Void) -> Point {
      var currentPosition = from

      (1 ... self.length).forEach { _ in
        currentPosition = Point(x: currentPosition.x + self.direction.dx, y: currentPosition.y + self.direction.dy)
        action(currentPosition)
      }

      return currentPosition
    }
  }
}

private extension String {
  var wiresSegments: [[Year2019Day3.Segment]] {
    commaSeparatedLines.map { wire in
      wire.map { segmentString in
        .init(string: segmentString)
      }
    }
  }
}
