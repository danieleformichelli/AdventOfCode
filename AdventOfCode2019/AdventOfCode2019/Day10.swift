//
//  Day10.swift
//  AdventOfCode2019
//
//  Created by Daniele Formichelli on 10/12/2019.
//  Copyright © 2019 Daniele Formichelli. All rights reserved.
//

/**
**/
struct Day10: DayBase {
  func part1(_ input: String) -> Any {
    let asteroids = self.asteroids
    let targetPosition = self.asteroidWithMoreDetectableAsteroids(asteroids: asteroids)
    return targetPosition.detectableAsteroids(asteroids: asteroids).count
  }

  func part2(_ input: String) -> Any {
    var asteroids = self.asteroids
    let laserPosition = self.asteroidWithMoreDetectableAsteroids(asteroids: asteroids)

    asteroids.remove(laserPosition)
    var vaporizationOrder: [Point] = []
    while !asteroids.isEmpty {
      let detectableAsteroids = laserPosition.detectableAsteroids(asteroids: asteroids)
      let thisRoundVaporizationOrder = detectableAsteroids.sorted { lhs, rhs in
        let lhsRecentered = lhs.translated(to: laserPosition)
        let rhsRecentered = rhs.translated(to: laserPosition)
        return lhsRecentered.clockwiseDegrees < rhsRecentered.clockwiseDegrees
      }
      vaporizationOrder.append(contentsOf: thisRoundVaporizationOrder)
      for asteroid in detectableAsteroids {
        asteroids.remove(asteroid)
      }
    }

    let resultAsteroid = vaporizationOrder[199]
    return resultAsteroid.x * 100 + resultAsteroid.y
  }

  func asteroidWithMoreDetectableAsteroids(asteroids: Set<Point>) -> Point {
    var maxDetectableAsteroids = 0
    var asteroidWithMoreDetectableAsteroids = Point(x: -1, y: -1)
    for asteroid in asteroids {
      let detectableAsteroids = asteroid.detectableAsteroids(asteroids: asteroids).count
      if detectableAsteroids > maxDetectableAsteroids {
        asteroidWithMoreDetectableAsteroids = asteroid
        maxDetectableAsteroids = detectableAsteroids
      }
    }

    return asteroidWithMoreDetectableAsteroids
  }
}

fileprivate extension Point {
  func translated(to center: Point) -> Point {
    return Point(x: self.x - center.x, y: center.y - self.y)
  }

  var clockwiseDegrees: Double {
    switch (self.x, self.y) {
    case (let x, let y) where x == 0 && y > 0:
      // positive y axis
      return 0
    case (let x, let y) where x == 0 && y < 0:
      // negative y axis
      return 180
    case (let x, let y) where x > 0 && y == 0:
      // positive x axis
      return 90
    case (let x, let y) where x < 0 && y == 0:
      // negative x axis
      return 270
    case (let x, let y) where x > 0 && y < 0:
      // second quadrant
      let portedToFirstQuadrant = Point(x: -y, y: x)
      return 90 + portedToFirstQuadrant.clockwiseDegrees
    case (let x, let y) where x < 0 && y < 0:
      // third quadrant
      let portedToFirstQuadrant = Point(x: -x, y: -y)
      return 180 + portedToFirstQuadrant.clockwiseDegrees
    case (let x, let y) where x < 0 && y > 0:
      // fourth quadrant
      let portedToFirstQuadrant = Point(x: y, y: -x)
      return 270 + portedToFirstQuadrant.clockwiseDegrees
    case (let x, let y):
      //first quadrant
      if y > x {
        // first half of the quadrant
        return 45 * Double(x) / Double(y)
      } else {
        // second half of the quadrant
        return 90 - 45 * Double(y) / Double(x)
      }
    }
  }

  func detectableAsteroids(asteroids: Set<Point>) -> Set<Point> {
    return asteroids.filter { self.canDetect($0, asteroids: asteroids) }
  }

  private func canDetect(_ otherAsteroid: Point, asteroids: Set<Point>) -> Bool {
    if self == otherAsteroid {
      return false
    }

    let xDifference = otherAsteroid.x - self.x
    let yDifference = otherAsteroid.y - self.y
    let gcd = Self.gcd(abs(xDifference), abs(yDifference))
    let dx = xDifference / gcd
    let dy = yDifference / gcd

    var currentPoint = Point(x: self.x + dx, y: self.y + dy)
    while currentPoint != otherAsteroid {
      guard !asteroids.contains(currentPoint) else { return false }
      currentPoint = Point(x: currentPoint.x + dx, y: currentPoint.y + dy)
    }

    return true
  }

  private static func gcd(_ m: Int, _ n: Int) -> Int {
    if m == n {
      return m
    } else if m == 0 {
      return n
    } else if n == 0 {
      return m
    }

    if (m & 1) == 0 {
      // m is even
      if (n & 1) == 1 {
        // and n is odd
        return self.gcd(m >> 1, n)
      } else {
        // both m and n are even
        return self.gcd(m >> 1, n >> 1) << 1
      }
    } else if (n & 1) == 0 {
      // m is odd, n is even
      return self.gcd(m, n >> 1)
    } else if (m > n) {
      // reduce larger argument
      return self.gcd((m - n) >> 1, n)
    } else {
      // reduce larger argument
      return self.gcd((n - m) >> 1, m)
    }
  }
}

extension Day10 {
  var asteroids: Set<Point> {
    var asteroids: Set<Point> = []
    let mapLines = self.inputLines
    for (y, line) in mapLines.enumerated() {
      for (x, character) in line.enumerated() {
        if character == "#" {
          asteroids.insert(Point(x: x, y: y))
        }
      }
    }
    return asteroids
  }

  var input: String {
    """
    ..............#.#...............#....#....
    #.##.......#....#.#..##........#...#......
    ..#.....#....#..#.#....#.....#.#.##..#..#.
    ...........##...#...##....#.#.#....#.##..#
    ....##....#...........#..#....#......#.###
    .#...#......#.#.#.#...#....#.##.##......##
    #.##....#.....#.....#...####........###...
    .####....#.......#...##..#..#......#...#..
    ...............#...........#..#.#.#.......
    ........#.........##...#..........#..##...
    ...#..................#....#....##..#.....
    .............#..#.#.........#........#.##.
    ...#.#....................##..##..........
    .....#.#...##..............#...........#..
    ......#..###.#........#.....#.##.#......#.
    #......#.#.....#...........##.#.....#..#.#
    .#.............#..#.....##.....###..#..#..
    .#...#.....#.....##.#......##....##....#..
    .........#.#..##............#..#...#......
    ..#..##...#.#..#....#..#.#.......#.##.....
    #.......#.#....#.#..##.#...#.......#..###.
    .#..........#...##.#....#...#.#.........#.
    ..#.#.......##..#.##..#.......#.###.......
    ...#....###...#......#..#.....####........
    .............#.#..........#....#......#...
    #................#..................#.###.
    ..###.........##...##..##.................
    .#.........#.#####..#...##....#...##......
    ........#.#...#......#.................##.
    .##.....#..##.##.#....#....#......#.#....#
    .....#...........#.............#.....#....
    ........#.##.#...#.###.###....#.#......#..
    ..#...#.......###..#...#.##.....###.....#.
    ....#.....#..#.....#...#......###...###...
    #..##.###...##.....#.....#....#...###..#..
    ........######.#...............#...#.#...#
    ...#.....####.##.....##...##..............
    ###..#......#...............#......#...#..
    #..#...#.#........#.#.#...#..#....#.#.####
    #..#...#..........##.#.....##........#.#..
    ........#....#..###..##....#.#.......##..#
    .................##............#.......#..
    """
  }
}
