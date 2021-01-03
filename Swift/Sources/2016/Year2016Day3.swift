//
//  Year2016Day3.swift
//
//  Copyright © 2021 Bending Spoons. All rights reserved.
//

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
    let space = Prefix<Substring> { $0 == " "}
    let triangle = Skip(space)
      .take(Int.parser())
      .skip(space)
      .take(Int.parser())
      .skip(space)
      .take(Int.parser())
      .map { Triangle(a: $0, b: $1, c: $2) }
    return Many(triangle, separator: StartsWith("\n")).parse(self)!
  }
}
