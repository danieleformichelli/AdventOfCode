//
//  File.swift
//  
//
//  Created by Daniele Formichelli on 17/11/2019.
//

import Foundation

enum Utils {
  static func readLines(from input: String) -> [String] {
    return input.components(separatedBy: "\n")
  }
}
