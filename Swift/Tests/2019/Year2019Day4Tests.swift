//
//  Year2019Day4Tests.swift
//  Tests
//
//  Created by Daniele Formichelli on 04/12/2019.
//  Copyright © 2019 Daniele Formichelli. All rights reserved.
//

@testable import AdventOfCode2019
import XCTest

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
