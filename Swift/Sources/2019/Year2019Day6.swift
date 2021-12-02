// Created by Daniele Formichelli.

import Utils

/// https://adventofcode.com/2019/day/6
struct Year2019Day6: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    self.calculateAllDistancesFromCOM(for: input.orbits).values.sum
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    let orbits = input.orbits
    let distancesFromCOM = self.calculateAllDistancesFromCOM(for: orbits)

    let you = "YOU"
    let santa = "SAN"
    let youDistanceFromCOM = distancesFromCOM[you]!
    let santaDistanceFromCOM = distancesFromCOM[santa]!

    var positionFromYou = orbits[you]!
    var positionFromSanta = orbits[santa]!

    var requiredOrbitalTransfers = 0

    // if you and santa are not at the same distance from the COM, move the furthest one to be at the same distance
    if youDistanceFromCOM > santaDistanceFromCOM {
      let moveBy = youDistanceFromCOM - santaDistanceFromCOM
      positionFromYou = self.moveTowardsCom(from: positionFromYou, by: moveBy, for: orbits)
      requiredOrbitalTransfers += moveBy
    } else if santaDistanceFromCOM > youDistanceFromCOM {
      let moveBy = santaDistanceFromCOM - youDistanceFromCOM
      positionFromSanta = self.moveTowardsCom(from: positionFromSanta, by: moveBy, for: orbits)
      requiredOrbitalTransfers += moveBy
    }

    // step you and santa together towards COM until they met
    while positionFromSanta != positionFromYou {
      positionFromSanta = orbits[positionFromSanta]!
      positionFromYou = orbits[positionFromYou]!
      requiredOrbitalTransfers += 2
    }

    return requiredOrbitalTransfers
  }

  private func calculateAllDistancesFromCOM(for orbits: [String: String]) -> [String: Int] {
    var distancesFromCOM: [String: Int] = [:]
    for orbiting in orbits.keys {
      self.calculateDistanceFromCOM(for: orbiting, orbits: orbits, cache: &distancesFromCOM)
    }
    return distancesFromCOM
  }

  @discardableResult
  private func calculateDistanceFromCOM(for orbiting: String, orbits: [String: String], cache: inout [String: Int]) -> Int {
    if let cachedValue = cache[orbiting] {
      return cachedValue
    }

    let distanceFromCOM: Int
    if let orbitCenter = orbits[orbiting] {
      distanceFromCOM = 1 + self.calculateDistanceFromCOM(for: orbitCenter, orbits: orbits, cache: &cache)
    } else {
      distanceFromCOM = 0
    }

    cache[orbiting] = distanceFromCOM
    return distanceFromCOM
  }

  private func moveTowardsCom(from object: String, by remainingSteps: Int, for orbits: [String: String]) -> String {
    guard remainingSteps > 0 else { return object }
    let nextObject = orbits[object]!
    return self.moveTowardsCom(from: nextObject, by: remainingSteps - 1, for: orbits)
  }
}

extension String {
  fileprivate var orbits: [String: String] {
    var orbits: [String: String] = [:]
    for orbit in lines {
      let centerAndOrbiting = orbit.components(separatedBy: ")")
      let center = centerAndOrbiting[0]
      let orbiting = centerAndOrbiting[1]
      orbits[orbiting] = center
    }

    return orbits
  }
}
