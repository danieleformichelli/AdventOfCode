// Created by Daniele Formichelli.

import XCTest
@testable import AdventOfCode2020

class Year2020Day13Tests: XCTestCase {
  func testPart1() {
    XCTAssertEqual(Year2020Day13().part1(Self.input).debugDescription, "259")
  }

  func testPart2() {
    XCTAssertEqual(Year2020Day13().part2(Self.input).debugDescription, "210612924879242")
  }

  static var input: String {
    """
    1000510
    19,x,x,x,x,x,x,x,x,41,x,x,x,x,x,x,x,x,x,523,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,17,13,x,x,x,x,x,x,x,x,x,x,29,x,853,x,x,x,x,x,37,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,23
    """
  }
}
