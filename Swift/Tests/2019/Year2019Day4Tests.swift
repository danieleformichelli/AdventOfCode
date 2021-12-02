// Created by Daniele Formichelli.

import XCTest
@testable import AdventOfCode2019

class Year2019Day4Tests: XCTestCase {
  func testPart1() {
    XCTAssertEqual(Year2019Day4().part1(Self.input).debugDescription, "1246")
  }

  func testPart2() {
    XCTAssertEqual(Year2019Day4().part2(Self.input).debugDescription, "814")
  }

  static var input: String {
    """
    234208-765869
    """
  }
}
