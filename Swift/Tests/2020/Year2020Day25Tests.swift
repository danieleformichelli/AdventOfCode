//
//  Year2020Day25Tests.swift
//  Tests
//
//  Created by Daniele Formichelli on 25/12/20.
//  Copyright © 2020 Daniele Formichelli. All rights reserved.
//

@testable import AdventOfCode2020
import XCTest

class Year2020Day25Tests: XCTestCase {
  func testPart1() {
    XCTAssertEqual(Year2020Day25().part1(Self.input).debugDescription, "8329514")
  }

  func testPart2() {
    XCTAssertEqual(Year2020Day25().part2(Self.input).debugDescription, "".debugDescription)
  }

  static var input: String {
    """
    13135480
    8821721
    """
  }
}
