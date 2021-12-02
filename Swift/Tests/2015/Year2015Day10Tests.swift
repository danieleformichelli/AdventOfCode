// Created by Daniele Formichelli.

import XCTest
@testable import AdventOfCode2015

class Year2015Day10Tests: XCTestCase {
  func testPart1() {
    XCTAssertEqual(Year2015Day10().part1(Self.input).debugDescription, "252594")
  }

  func testPart2() {
    XCTAssertEqual(Year2015Day10().part2(Self.input).debugDescription, "3579328")
  }

  static var input: String {
    """
    1113222113
    """
  }
}
