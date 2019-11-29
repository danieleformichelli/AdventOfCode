//
//  File.swift
//  
//
//  Created by Daniele Formichelli on 17/11/2019.
//

import Foundation

enum Utils {
  static func readSingleLine(from filename: String) -> String {
    return Self.readLines(from: filename)[0]
  }

  static func readLines(from filename: String) -> [String] {
    guard let fileContent = try? String(contentsOfFile: filename) else {
      return []
    }

    return fileContent.components(separatedBy: "\n")
  }
}
