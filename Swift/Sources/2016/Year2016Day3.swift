// Created by Daniele Formichelli.

import Parsing
import Utils

/// https://adventofcode.com/2016/day/3
struct Year2016Day3: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    return input.triangles.filter(\.isValid).count
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    let triangles = input.triangles
    var valid = 0
    var i = 0
    while i < triangles.count {
      let first = triangles[i]
      let second = triangles[i + 1]
      let third = triangles[i + 2]
      let firstByColumn = Triangle(a: first.a, b: second.a, c: third.a)
      let secondByColumn = Triangle(a: first.b, b: second.b, c: third.b)
      let thirdByColumn = Triangle(a: first.c, b: second.c, c: third.c)
      valid += [firstByColumn, secondByColumn, thirdByColumn].filter(\.isValid).count
      i += 3
    }
    return valid
  }
}

private struct Triangle {
  let a: Int
  let b: Int
  let c: Int

  var isValid: Bool {
    return self.a + self.b > self.c && self.a + self.c > self.b && self.b + self.c > self.a
  }
}

extension String {
  fileprivate var triangles: [Triangle] {
    return self.lines.map { triangle in
      let split = triangle.components(separatedBy: " ").filter { !$0.isEmpty }
      return Triangle(a: Int(split[0])!, b: Int(split[1])!, c: Int(split[2])!)
    }
  }
}
