//
//  Year2020Day23Tests.swift
//  Tests
//
//  Created by Daniele Formichelli on 23/12/20.
//  Copyright © 2020 Daniele Formichelli. All rights reserved.
//

@testable import AdventOfCode2020
import XCTest

class Year2020Day23Tests: XCTestCase {
  func testPart1() {
    XCTAssertEqual(Year2020Day23().part1(Self.input).debugDescription, "34952786".debugDescription)
  }

  func testPart2() {
    XCTAssertEqual(Year2020Day23().part2(Self.input).debugDescription, "gbt,rpj,vdxb,dtb,bqmhk,vqzbq,zqjm,nhjrzzj")
  }

  static var input: String {
    """
    253149867
    """
  }
}
