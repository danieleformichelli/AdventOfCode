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
    59709511599794439805414014219880358445064269099345553494818286560304063399998657801629526113732466767578373307474609375929817361595469200826872565688108197109235040815426214109531925822745223338550232315662686923864318114370485155264844201080947518854684797571383091421294624331652208294087891792537136754322020911070917298783639755047408644387571604201164859259810557018398847239752708232169701196560341721916475238073458804201344527868552819678854931434638430059601039507016639454054034562680193879342212848230089775870308946301489595646123293699890239353150457214490749319019572887046296522891429720825181513685763060659768372996371503017206185697
    """
  }
}