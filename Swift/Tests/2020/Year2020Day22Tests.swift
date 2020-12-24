//
//  Year2020Day22Tests.swift
//  Tests
//
//  Created by Daniele Formichelli on 22/12/20.
//  Copyright © 2020 Daniele Formichelli. All rights reserved.
//

@testable import AdventOfCode2020
import XCTest

class Year2020Day22Tests: XCTestCase {
  func testPart1() {
    XCTAssertEqual(Year2020Day22().part1(Self.input).debugDescription, "32401")
  }

  func testPart2() {
    XCTAssertEqual(Year2020Day22().part2(Self.input).debugDescription, "31436")
  }

  static var input: String {
    """
    Player 1:
    40
    26
    44
    14
    3
    17
    36
    43
    47
    38
    39
    41
    23
    28
    49
    27
    18
    2
    13
    32
    29
    11
    25
    24
    35

    Player 2:
    19
    15
    48
    37
    6
    34
    8
    50
    22
    46
    20
    21
    10
    1
    33
    30
    4
    5
    7
    31
    12
    9
    45
    42
    16
    """
  }
}
