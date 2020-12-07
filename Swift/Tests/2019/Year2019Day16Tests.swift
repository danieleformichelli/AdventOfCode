//
//  Year2019Day16Tests.swift
//  Tests
//
//  Created by Daniele Formichelli on 16/12/2019.
//  Copyright © 2019 Daniele Formichelli. All rights reserved.
//

@testable import AdventOfCode2019
import XCTest

class Year2019Day16Tests: XCTestCase {
  func testPart1() {
    XCTAssertEqual(Year2019Day16().part1(Self.input).debugDescription, "9493")
  }

  func testPart2() {
    XCTAssertEqual(Year2019Day16().part2(Self.input).debugDescription, "326365108375488")
  }

  static var input: String {
    """
    <x=4, y=1, z=1>
    <x=11, y=-18, z=-1>
    <x=-2, y=-10, z=-4>
    <x=-7, y=-2, z=14>
    """
  }
}
