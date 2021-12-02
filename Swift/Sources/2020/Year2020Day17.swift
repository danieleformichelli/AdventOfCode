// Created by Daniele Formichelli.

import Utils

/// https://adventofcode.com/2020/day/17
public struct Year2020Day17: DayBase {
  public func part1(_ input: String) -> CustomDebugStringConvertible {
    return self.run(input, fourDimensional: false)
  }

  public func part2(_ input: String) -> CustomDebugStringConvertible {
    return self.run(input, fourDimensional: true)
  }

  private func run(_ input: String, fourDimensional: Bool) -> Int {
    var activeCoordinates = input.activeCoordinates
    var minX = activeCoordinates.minX
    var minY = activeCoordinates.minY
    var minZ = activeCoordinates.minZ
    var minW = activeCoordinates.minW
    var maxX = activeCoordinates.maxX
    var maxY = activeCoordinates.maxY
    var maxZ = activeCoordinates.maxZ
    var maxW = activeCoordinates.maxW

    (1 ... 6).forEach { _ in
      var deactivated: Set<Coordinate> = []
      for coordinate in activeCoordinates {
        if !(2 ... 3).contains(self.activeNeighbors(for: coordinate, in: activeCoordinates)) {
          deactivated.insert(coordinate)
        }
      }

      var activated: Set<Coordinate> = []
      for x in minX - 1 ... maxX + 1 {
        for y in minY - 1 ... maxY + 1 {
          for z in minZ - 1 ... maxZ + 1 {
            for w in minW - 1 ... maxW + 1 {
              guard fourDimensional || w == 0 else { continue }
              let coordinate = Coordinate(x: x, y: y, z: z, w: w)
              if !activeCoordinates.contains(coordinate), self.activeNeighbors(for: coordinate, in: activeCoordinates) == 3 {
                activated.insert(coordinate)
              }
            }
          }
        }
      }

      // update active coordinates

      activeCoordinates.formSymmetricDifference(activated)
      activeCoordinates.formSymmetricDifference(deactivated)

      // recompute mins and maxes if needed

      minX = min(minX, activated.minX)
      minY = min(minY, activated.minY)
      minZ = min(minZ, activated.minZ)
      minW = min(minW, activated.minW)
      maxX = max(maxX, activated.maxX)
      maxY = max(maxY, activated.maxY)
      maxZ = max(maxZ, activated.maxZ)
      maxW = max(maxW, activated.maxW)

      if deactivated.minX == minX {
        minX = activeCoordinates.minX
      }
      if deactivated.minY == minY {
        minY = activeCoordinates.minY
      }
      if deactivated.minZ == minZ {
        minZ = activeCoordinates.minZ
      }
      if deactivated.minW == minW {
        minW = activeCoordinates.minW
      }
      if deactivated.maxX == maxX {
        maxX = activeCoordinates.maxX
      }
      if deactivated.maxY == maxY {
        maxY = activeCoordinates.maxY
      }
      if deactivated.maxZ == maxZ {
        maxZ = activeCoordinates.maxZ
      }
      if deactivated.maxW == maxW {
        maxW = activeCoordinates.maxW
      }
    }

    return activeCoordinates.count
  }

  private func activeNeighbors(for activeCoordinate: Coordinate, in activeCoordinates: Set<Coordinate>) -> Int {
    var activeNeighbors = 0
    for x in activeCoordinate.x - 1 ... activeCoordinate.x + 1 {
      for y in activeCoordinate.y - 1 ... activeCoordinate.y + 1 {
        for z in activeCoordinate.z - 1 ... activeCoordinate.z + 1 {
          for w in activeCoordinate.w - 1 ... activeCoordinate.w + 1 {
            let coordinate = Coordinate(x: x, y: y, z: z, w: w)
            guard coordinate != activeCoordinate,
                  activeCoordinates.contains(coordinate)
            else {
              continue
            }
            activeNeighbors += 1
          }
        }
      }
    }
    return activeNeighbors
  }
}

extension Year2020Day17 {
  fileprivate struct Coordinate: Hashable {
    public let x: Int
    public let y: Int
    public let z: Int
    public let w: Int

    public init(x: Int, y: Int, z: Int, w: Int) {
      self.x = x
      self.y = y
      self.z = z
      self.w = w
    }
  }
}

extension String {
  fileprivate var activeCoordinates: Set<Year2020Day17.Coordinate> {
    return self.lines.enumerated().flatMap { y, line in
      return line.enumerated().compactMap { x, element in
        guard element == "#" else { return nil }
        return .init(x: x, y: y, z: 0, w: 0)
      }
    }.asSet
  }
}

extension Set where Element == Year2020Day17.Coordinate {
  fileprivate var minX: Int {
    return self.min { $0.x < $1.x }!.x
  }

  fileprivate var minY: Int {
    return self.min { $0.y < $1.y }!.y
  }

  fileprivate var minZ: Int {
    return self.min { $0.z < $1.z }!.z
  }

  fileprivate var minW: Int {
    return self.min { $0.w < $1.w }!.w
  }

  fileprivate var maxX: Int {
    return self.max { $0.x < $1.x }!.x
  }

  fileprivate var maxY: Int {
    return self.max { $0.y < $1.y }!.y
  }

  fileprivate var maxZ: Int {
    return self.max { $0.z < $1.z }!.z
  }

  fileprivate var maxW: Int {
    return self.max { $0.w < $1.w }!.w
  }
}
