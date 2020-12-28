//
//  Year2015Day4Tests.swift
//  AdventOfCode2015Tests
//

@testable import AdventOfCode2015
import XCTest

class Year2015Day4Tests: XCTestCase {
  func testPart1() {
    XCTAssertEqual(Year2015Day4().part1(Self.input).debugDescription, "282749")
  }

  func testPart2() {
    XCTAssertEqual(Year2015Day4().part2(Self.input).debugDescription, "9962624")
  }

  static var input: String {
    """
    yzbqklnj
    """
  }
}
