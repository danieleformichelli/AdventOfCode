//
//  Utils.swift
//  AdventOfCode2019
//
//  Created by Daniele Formichelli on 15/12/2019.
//  Copyright © 2019 Daniele Formichelli. All rights reserved.
//

protocol MapElement {
  var representation: String { get }
}

extension Dictionary where Key == Point, Value: MapElement {
  func print(invertedY: Bool, clearElement: Value) -> String {
    let minX = self.keys.min { (lhs, rhs) in lhs.x < rhs.x }!.x
    let maxX = self.keys.min { (lhs, rhs) in lhs.x > rhs.x }!.x
    let minY = self.keys.min { (lhs, rhs) in lhs.y < rhs.y }!.y
    let maxY = self.keys.min { (lhs, rhs) in lhs.y > rhs.y }!.y

    let yStride = invertedY ? stride(from: minY, through: maxY, by: 1) : stride(from: maxY, through: minY, by: -1)

    var result = ""
    for y in yStride {
      for x in minX...maxX {
        let element = self[Point(x: x, y: y)]
        result += element?.representation ?? clearElement.representation
      }

      result += "\n"
    }

    return result
  }
}

enum Utils {
  static func gcd(_ m: Int64, _ n: Int64) -> Int64 {
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
        return gcd(m >> 1, n)
      } else {
        // both m and n are even
        return gcd(m >> 1, n >> 1) << 1
      }
    } else if (n & 1) == 0 {
      // m is odd, n is even
      return gcd(m, n >> 1)
    } else if (m > n) {
      // reduce larger argument
      return gcd((m - n) >> 1, n)
    } else {
      // reduce larger argument
      return gcd((n - m) >> 1, m)
    }
  }

  static func lcm(_ m: Int64, _ n: Int64) -> Int64 {
    return m / gcd(m, n) * n
  }
}
