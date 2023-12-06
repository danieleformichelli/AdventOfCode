// Created by Daniele Formichelli.

import XCTest
@testable import AdventOfCode2023

class Year2023Day6Tests: XCTestCase {
  func testPart1() {
    XCTAssertEqual(Year2023Day6().part1(Self.input).debugDescription, "220320")
  }

  func testPart2() {
    XCTAssertEqual(Year2023Day6().part2(Self.input).debugDescription, "34454850")
  }

  static var input: String {
    """
    Time:        59     79     65     75
    Distance:   597   1234   1032   1328
    """
  }
}
