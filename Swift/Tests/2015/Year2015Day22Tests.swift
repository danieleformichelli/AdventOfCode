// Created by Daniele Formichelli.

import XCTest
@testable import AdventOfCode2015

class Year2015Day22Tests: XCTestCase {
  func testPart1() {
    XCTAssertEqual(Year2015Day22().part1(Self.input).debugDescription, "953")
  }

  func testPart2() {
    XCTAssertEqual(Year2015Day22().part2(Self.input).debugDescription, "1289")
  }

  static var input: String {
    """
    Hit Points: 55
    Damage: 8
    """
  }
}
