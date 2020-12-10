//
//  Year2020Day10Tests.swift
//  Tests
//
//  Created by Daniele Formichelli on 10/12/20.
//  Copyright © 2020 Daniele Formichelli. All rights reserved.
//

@testable import AdventOfCode2020
import XCTest

class Year2020Day10Tests: XCTestCase {
  func testPart1() {
    XCTAssertEqual(Year2020Day10().part1(Self.input).debugDescription, "1836")
  }

  func testPart2() {
    XCTAssertEqual(Year2020Day10().part2(Self.input).debugDescription, "43406276662336")
  }

  static var input: String {
    """
    71
    30
    134
    33
    51
    115
    122
    38
    61
    103
    21
    12
    44
    129
    29
    89
    54
    83
    96
    91
    133
    102
    99
    52
    144
    82
    22
    68
    7
    15
    93
    125
    14
    92
    1
    146
    67
    132
    114
    59
    72
    107
    34
    119
    136
    60
    20
    53
    8
    46
    55
    26
    126
    77
    65
    78
    13
    108
    142
    27
    75
    110
    90
    35
    143
    86
    116
    79
    48
    113
    101
    2
    123
    58
    19
    76
    16
    66
    135
    64
    28
    9
    6
    100
    124
    47
    109
    23
    139
    145
    5
    45
    106
    41
    """
  }
}
