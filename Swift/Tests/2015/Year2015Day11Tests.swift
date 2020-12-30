//
//  Year2015Day11Tests.swift
//
//  Copyright © 2020 Bending Spoons. All rights reserved.
//

@testable import AdventOfCode2015
import XCTest

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
