//
//  Year2020Day17Tests.swift
//  Tests
//
//  Created by Daniele Formichelli on 17/12/20.
//  Copyright © 2020 Daniele Formichelli. All rights reserved.
//

@testable import AdventOfCode2020
import XCTest

class Year2020Day17Tests: XCTestCase {
  func testPart1() {
    XCTAssertEqual(Year2020Day17().part1(Self.input).debugDescription, "242")
  }

  func testPart2() {
    XCTAssertEqual(Year2020Day17().part2(Self.input).debugDescription, "2292")
  }

  static var input: String {
    """
    ..#..#..
    .###..#.
    #..##.#.
    #.#.#.#.
    .#..###.
    .....#..
    #...####
    ##....#.
    """
  }
}
