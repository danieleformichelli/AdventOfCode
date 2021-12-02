// Created by Daniele Formichelli.

import XCTest
@testable import AdventOfCode2015

class Year2015Day15Tests: XCTestCase {
  func testPart1() {
    XCTAssertEqual(Year2015Day15().part1(Self.input).debugDescription, "18965440")
  }

  func testPart2() {
    XCTAssertEqual(Year2015Day15().part2(Self.input).debugDescription, "15862900")
  }

  static var input: String {
    """
    Frosting: capacity 4, durability -2, flavor 0, texture 0, calories 5
    Candy: capacity 0, durability 5, flavor -1, texture 0, calories 8
    Butterscotch: capacity -1, durability 0, flavor 5, texture 0, calories 6
    Sugar: capacity 0, durability 0, flavor -2, texture 2, calories 1
    """
  }
}
