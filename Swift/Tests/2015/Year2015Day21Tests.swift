// Created by Daniele Formichelli.

import XCTest
@testable import AdventOfCode2015

class Year2015Day21Tests: XCTestCase {
  func testPart1() {
    XCTAssertEqual(Year2015Day21().part1(Self.input).debugDescription, "78")
  }

  func testPart2() {
    XCTAssertEqual(Year2015Day21().part2(Self.input).debugDescription, "148")
  }

  static var input: String {
    """
    Hit Points: 104
    Damage: 8
    Armor: 1
    """
  }
}
