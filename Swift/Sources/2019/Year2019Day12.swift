// Created by Daniele Formichelli.

import Utils

/// https://adventofcode.com/2019/day/12
struct Year2019Day12: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    var moonPositionsPerCoordinate = input.moonPositions
    var moonVelocitiesPerCoordinate = moonPositionsPerCoordinate.map { $0.map { _ in 0 } }

    let moonsCount = moonPositionsPerCoordinate[0].count
    for _ in 1 ... 1000 {
      self.performStep(
        moonPositionsPerCoordinate: &moonPositionsPerCoordinate,
        moonVelocitiesPerCoordinate: &moonVelocitiesPerCoordinate
      )
    }

    let coordsCount = 3
    return (0 ..< moonsCount)
      .map { moonIndex -> Int in
        let potentialEnergy = (0 ..< coordsCount).map { abs(moonPositionsPerCoordinate[$0][moonIndex]) }.sum
        let kineticEnergy = (0 ..< coordsCount).map { abs(moonVelocitiesPerCoordinate[$0][moonIndex]) }.sum
        return potentialEnergy * kineticEnergy
      }
      .sum
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    var moonPositionsPerCoordinate = input.moonPositions
    var moonVelocitiesPerCoordinate = moonPositionsPerCoordinate.map { $0.map { _ in 0 } }
    var pastPositionsAndVelocitiesX: [PositionsAndVelocities: Int64] = [:]
    var pastPositionsAndVelocitiesY: [PositionsAndVelocities: Int64] = [:]
    var pastPositionsAndVelocitiesZ: [PositionsAndVelocities: Int64] = [:]

    var currentStep: Int64 = 0
    var xPeriod: Int64 = 0
    var yPeriod: Int64 = 0
    var zPeriod: Int64 = 0
    while xPeriod == 0 || yPeriod == 0 || zPeriod == 0 {
      self.performStep(
        moonPositionsPerCoordinate: &moonPositionsPerCoordinate,
        moonVelocitiesPerCoordinate: &moonVelocitiesPerCoordinate
      )

      let positionsAndVelocitiesX = PositionsAndVelocities(
        positions: moonPositionsPerCoordinate[0],
        velocities: moonVelocitiesPerCoordinate[0]
      )
      if let previousStep = pastPositionsAndVelocitiesX[positionsAndVelocitiesX] {
        xPeriod = currentStep - previousStep
      } else {
        pastPositionsAndVelocitiesX[positionsAndVelocitiesX] = currentStep
      }

      let positionsAndVelocitiesY = PositionsAndVelocities(
        positions: moonPositionsPerCoordinate[1],
        velocities: moonVelocitiesPerCoordinate[1]
      )
      if let previousStep = pastPositionsAndVelocitiesY[positionsAndVelocitiesY] {
        yPeriod = currentStep - previousStep
      } else {
        pastPositionsAndVelocitiesY[positionsAndVelocitiesY] = currentStep
      }

      let positionsAndVelocitiesZ = PositionsAndVelocities(
        positions: moonPositionsPerCoordinate[2],
        velocities: moonVelocitiesPerCoordinate[2]
      )
      if let previousStep = pastPositionsAndVelocitiesZ[positionsAndVelocitiesZ] {
        zPeriod = currentStep - previousStep
      } else {
        pastPositionsAndVelocitiesZ[positionsAndVelocitiesZ] = currentStep
      }

      currentStep += 1
    }

    return Utils.lcm(Utils.lcm(xPeriod, yPeriod), zPeriod)
  }

  func performStep(moonPositionsPerCoordinate: inout [[Int]], moonVelocitiesPerCoordinate: inout [[Int]]) {
    for coordIndex in 0 ..< moonPositionsPerCoordinate.count {
      let moonCoordPositions = moonPositionsPerCoordinate[coordIndex]

      for (moonIndex, moonCoordPosition) in moonCoordPositions.enumerated() {
        for otherMoonCoordPosition in moonCoordPositions {
          let coordDifference = otherMoonCoordPosition - moonCoordPosition
          guard coordDifference != 0 else { continue }
          let gravity = coordDifference / abs(coordDifference)
          moonVelocitiesPerCoordinate[coordIndex][moonIndex] = moonVelocitiesPerCoordinate[coordIndex][moonIndex] + gravity
        }
      }

      for moonIndex in 0 ..< moonCoordPositions.count {
        let moonPosition = moonPositionsPerCoordinate[coordIndex][moonIndex]
        let moonVelocity = moonVelocitiesPerCoordinate[coordIndex][moonIndex]
        moonPositionsPerCoordinate[coordIndex][moonIndex] = moonPosition + moonVelocity
      }
    }
  }
}

extension Year2019Day12 {
  private struct PositionsAndVelocities: Hashable {
    let positions: [Int]
    let velocities: [Int]
  }
}

extension String {
  var moonPositions: [[Int]] {
    var xPositions: [Int] = []
    var yPositions: [Int] = []
    var zPositions: [Int] = []

    lines.forEach { line in
      let coordinates = line
        .replacingOccurrences(of: "<x=", with: "")
        .replacingOccurrences(of: ",", with: "")
        .replacingOccurrences(of: "y=", with: "")
        .replacingOccurrences(of: "z=", with: "")
        .replacingOccurrences(of: ">", with: "")
        .components(separatedBy: " ")
        .compactMap { Int($0) }

      xPositions.append(coordinates[0])
      yPositions.append(coordinates[1])
      zPositions.append(coordinates[2])
    }

    return [xPositions, yPositions, zPositions]
  }
}
