//
//  Year2015Day17Tests.swift
//
//  Copyright © 2020 Bending Spoons. All rights reserved.
//

@testable import AdventOfCode2015
import XCTest

class Year2015Day17Tests: XCTestCase {
  func testPart1() {
    XCTAssertEqual(Year2015Day17().part1(Self.input).debugDescription, "4372")
  }

  func testPart2() {
    XCTAssertEqual(Year2015Day17().part2(Self.input).debugDescription, "4")
  }

  static var input: String {
    """
    11
    30
    47
    31
    32
    36
    3
    1
    5
    3
    32
    36
    15
    11
    46
    26
    28
    1
    19
    3
    """
  }
}
