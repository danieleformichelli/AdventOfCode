// Created by Daniele Formichelli.

import XCTest
@testable import AdventOfCode2015

class Year2015Day11Tests: XCTestCase {
  func testPart1() {
    XCTAssertEqual(Year2015Day11().part1(Self.input).debugDescription, "vzbxxyzz".debugDescription)
  }

  func testPart2() {
    XCTAssertEqual(Year2015Day11().part2(Self.input).debugDescription, "vzcaabcc".debugDescription)
  }

  static var input: String {
    """
    vzbxkghb
    """
  }
}
