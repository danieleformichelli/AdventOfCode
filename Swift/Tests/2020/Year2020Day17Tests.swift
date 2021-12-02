// Created by Daniele Formichelli.

import XCTest
@testable import AdventOfCode2020

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
