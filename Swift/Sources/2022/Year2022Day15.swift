// Created by Daniele Formichelli.

import Foundation
import Utils

/// https://adventofcode.com/2022/day/15
struct Year2022Day15: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    let reference = 2000000
    var noBeaconPoints: Set<Point> = []
    for data in input.sensorsData {
      let distanceFromBeacon = data.sensor.manhattanDistance(from: data.beacon)
      let distanceFromReference = data.sensor.manhattanDistance(from: .init(x: data.sensor.x, y: reference))
      let delta = distanceFromBeacon - distanceFromReference
      if delta >= 0 {
        for x in data.sensor.x - delta ... data.sensor.x + delta {
          let point = Point(x: x, y: reference)
          if point != data.beacon {
            noBeaconPoints.insert(point)
          }
        }
      }
    }
    return noBeaconPoints.count
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    return 0
  }
}

extension String {
  var sensorsData: [(sensor: Point, beacon: Point)] {
    return self.lines.map { line in
      func point(from string: String) -> Point {
        let split = string.dropFirst(2).split(separator: ", y=")
        return .init(x: Int(String(split[0]))!, y: Int(String(split[1]))!)
      }
      let split = line.dropFirst("Sensor at ".count).split(separator: ": closest beacon is at ")
      return (sensor: point(from: String(split[0])), beacon: point(from: String(split[1])))
    }
  }
}
