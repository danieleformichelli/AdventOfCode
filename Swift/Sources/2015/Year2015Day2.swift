//
//  Year2015Day2.swift
//  AdventOfCode2015
//

import Parsing
import Utils

/// https://adventofcode.com/2015/day/2
struct Year2015Day2: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    return input.dimensions.map { dimensions -> Int in
      let lengthByWidth = dimensions.length * dimensions.width
      let lengthByHeight = dimensions.length * dimensions.height
      let widthByHeight = dimensions.width * dimensions.height
      return 2 * lengthByWidth + 2 * lengthByHeight + 2 * widthByHeight + min(lengthByWidth, lengthByHeight, widthByHeight)
    }.sum
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    return input.dimensions.map { dimensions -> Int in
      let largestSide = max(dimensions.length, dimensions.width, dimensions.height)
      let smallestPerimeter = 2 * (dimensions.length + dimensions.width + dimensions.height - largestSide)
      let volume = dimensions.length * dimensions.width * dimensions.height
      return smallestPerimeter + volume
    }.sum
  }
}

private struct Dimensions {
  let length: Int
  let width: Int
  let height: Int

  var surface: Int {
    let lengthByWidth = self.length * self.width
    let lengthByHeight = self.length * self.height
    let widthByHeight = self.width * self.height
    return 2 * lengthByWidth + 2 * lengthByHeight + 2 * widthByHeight + min(lengthByWidth, lengthByHeight, widthByHeight)
  }
}

extension String {
  fileprivate var dimensions: [Dimensions] {
    let dimension = Int.parser()
      .skip(StartsWith("x"))
      .take(Int.parser())
      .skip(StartsWith("x"))
      .take(Int.parser())
      .map { Dimensions(length: $0, width: $1, height: $2) }

    return Many(dimension, separator: StartsWith("\n")).parse(self)!
  }
}
