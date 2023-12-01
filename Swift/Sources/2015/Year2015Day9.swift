// Created by Daniele Formichelli.

import Parsing
import Utils

/// https://adventofcode.com/2015/day/9
struct Year2015Day9: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    let distances = input.distances
    return Self.shortestPath(remainingLocations: distances.allLocations, distances: distances, reduce: { $0.min() })
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    let distances = input.distances
    return Self.shortestPath(remainingLocations: distances.allLocations, distances: distances, reduce: { $0.max() })
  }

  private static func shortestPath(
    currentLocation: String? = nil,
    remainingLocations: Set<String>,
    distances: [Route: Int],
    reduce: ([Int]) -> Int?
  ) -> Int {
    let possibleDistances = remainingLocations
      .compactMap { destination -> Int? in
        let possibleDistances = distances
          .compactMap { route, distance -> Int? in
            guard route.locations.contains(destination) else { return nil }
            guard currentLocation == nil || route.locations.contains(currentLocation ?? "") else { return nil }

            let remaining = Self.shortestPath(
              currentLocation: destination,
              remainingLocations: remainingLocations.symmetricDifference([destination]),
              distances: distances,
              reduce: reduce
            )
            return currentLocation != nil ? distance + remaining : remaining
          }
        return reduce(possibleDistances)
      }
    return reduce(possibleDistances) ?? 0
  }
}

private struct Route: Hashable {
  let from: String
  let to: String
  
  var locations: [String] {
    return [self.from, self.to]
  }
}

extension String {
  fileprivate var distances: [Route: Int] {
    return Dictionary(uniqueKeysWithValues: self.lines.map {
      let split = $0.components(separatedBy: " = ")
      let routeSplit = split[0].components(separatedBy: " to ")
      return (Route(from: routeSplit[0], to: routeSplit[1]), Int(split[1])!)
    })
  }
}

extension Dictionary where Key == Route {
  var allLocations: Set<String> {
    self.keys.flatMap(\.locations).asSet
  }
}
