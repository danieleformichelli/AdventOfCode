// Created by Daniele Formichelli.

import XCTest
@testable import AdventOfCode2015

class Year2015Day20Tests: XCTestCase {
  func testPart1() {
    XCTAssertEqual(Year2015Day20().part1(Self.input).debugDescription, "776160")
  }

  func testPart2() {
    XCTAssertEqual(Year2015Day20().part2(Self.input).debugDescription, "786240")
  }

  static var input: String {
    """
    33100000
    """
  }
}
