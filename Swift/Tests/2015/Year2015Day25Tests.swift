//
//  Year2015Day25Tests.swift
//
//  Copyright © 2020 Bending Spoons. All rights reserved.
//

@testable import AdventOfCode2015
import XCTest

class Year2015Day25Tests: XCTestCase {
  func testPart1() {
    XCTAssertEqual(Year2015Day25().part1(Self.input).debugDescription, "9132360")
  }

  func testPart2() {
    XCTAssertEqual(Year2015Day25().part2(Self.input).debugDescription, "".debugDescription)
  }

  static var input: String {
    """
    To continue, please consult the code grid in the manual.  Enter the code at row 2981, column 3075.
    """
  }
}
