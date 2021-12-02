// Created by Daniele Formichelli.

import XCTest
@testable import AdventOfCode2020

class Year2020Day23Tests: XCTestCase {
  func testPart1() {
    XCTAssertEqual(Year2020Day23().part1(Self.input).debugDescription, "34952786".debugDescription)
  }

  func testPart2() {
    XCTAssertEqual(Year2020Day23().part2(Self.input).debugDescription, "505334281774")
  }

  static var input: String {
    """
    253149867
    """
  }
}
