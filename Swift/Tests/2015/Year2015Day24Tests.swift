//
//  Year2015Day24Tests.swift
//
//  Copyright © 2020 Bending Spoons. All rights reserved.
//

@testable import AdventOfCode2015
import XCTest

class Year2015Day24Tests: XCTestCase {
  func testPart1() {
    XCTAssertEqual(Year2015Day24().part1(Self.input).debugDescription, "11266889531")
  }

  func testPart2() {
    XCTAssertEqual(Year2015Day24().part2(Self.input).debugDescription, "77387711")
  }

  static var input: String {
    """
    1
    3
    5
    11
    13
    17
    19
    23
    29
    31
    41
    43
    47
    53
    59
    61
    67
    71
    73
    79
    83
    89
    97
    101
    103
    107
    109
    113
    """
  }
}
