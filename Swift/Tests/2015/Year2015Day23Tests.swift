//
//  Year2015Day23Tests.swift
//
//  Copyright © 2020 Bending Spoons. All rights reserved.
//

@testable import AdventOfCode2015
import XCTest

class Year2015Day23Tests: XCTestCase {
  func testPart1() {
    XCTAssertEqual(Year2015Day23().part1(Self.input).debugDescription, "255")
  }

  func testPart2() {
    XCTAssertEqual(Year2015Day23().part2(Self.input).debugDescription, "334")
  }

  static var input: String {
    """
    jio a, +22
    inc a
    tpl a
    tpl a
    tpl a
    inc a
    tpl a
    inc a
    tpl a
    inc a
    inc a
    tpl a
    inc a
    inc a
    tpl a
    inc a
    inc a
    tpl a
    inc a
    inc a
    tpl a
    jmp +19
    tpl a
    tpl a
    tpl a
    tpl a
    inc a
    inc a
    tpl a
    inc a
    tpl a
    inc a
    inc a
    tpl a
    inc a
    inc a
    tpl a
    inc a
    tpl a
    tpl a
    jio a, +8
    inc b
    jie a, +4
    tpl a
    inc a
    jmp +2
    hlf a
    jmp -7
    """
  }
}
