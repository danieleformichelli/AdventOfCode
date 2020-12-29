//
//  Year2015Day19Tests.swift
//
//  Copyright © 2020 Bending Spoons. All rights reserved.
//

@testable import AdventOfCode2015
import XCTest

class Year2015Day19Tests: XCTestCase {
  func testPart1() {
    XCTAssertEqual(Year2015Day19().part1(Self.input).debugDescription, "576")
  }

  func testPart2() {
    XCTAssertEqual(Year2015Day19().part2(Self.input).debugDescription, "")
  }

  static var input: String {
    """
    Al => ThF
    Al => ThRnFAr
    B => BCa
    B => TiB
    B => TiRnFAr
    Ca => CaCa
    Ca => PB
    Ca => PRnFAr
    Ca => SiRnFYFAr
    Ca => SiRnMgAr
    Ca => SiTh
    F => CaF
    F => PMg
    F => SiAl
    H => CRnAlAr
    H => CRnFYFYFAr
    H => CRnFYMgAr
    H => CRnMgYFAr
    H => HCa
    H => NRnFYFAr
    H => NRnMgAr
    H => NTh
    H => OB
    H => ORnFAr
    Mg => BF
    Mg => TiMg
    N => CRnFAr
    N => HSi
    O => CRnFYFAr
    O => CRnMgAr
    O => HP
    O => NRnFAr
    O => OTi
    P => CaP
    P => PTi
    P => SiRnFAr
    Si => CaSi
    Th => ThCa
    Ti => BP
    Ti => TiTi
    e => HF
    e => NAl
    e => OMg

    ORnPBPMgArCaCaCaSiThCaCaSiThCaCaPBSiRnFArRnFArCaCaSiThCaCaSiThCaCaCaCaCaCaSiRnFYFArSiRnMgArCaSiRnPTiTiBFYPBFArSiRnCaSiRnTiRnFArSiAlArPTiBPTiRnCaSiAlArCaPTiTiBPMgYFArPTiRnFArSiRnCaCaFArRnCaFArCaSiRnSiRnMgArFYCaSiRnMgArCaCaSiThPRnFArPBCaSiRnMgArCaCaSiThCaSiRnTiMgArFArSiThSiThCaCaSiRnMgArCaCaSiRnFArTiBPTiRnCaSiAlArCaPTiRnFArPBPBCaCaSiThCaPBSiThPRnFArSiThCaSiThCaSiThCaPTiBSiRnFYFArCaCaPRnFArPBCaCaPBSiRnTiRnFArCaPRnFArSiRnCaCaCaSiThCaRnCaFArYCaSiRnFArBCaCaCaSiThFArPBFArCaSiRnFArRnCaCaCaFArSiRnFArTiRnPMgArF
    """
  }
}
