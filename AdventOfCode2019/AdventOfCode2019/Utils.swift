//
//  Utils.swift
//  AdventOfCode2019
//
//  Created by Daniele Formichelli on 15/12/2019.
//  Copyright © 2019 Daniele Formichelli. All rights reserved.
//

protocol MapElement {
  var representation: String { get }
}

extension Dictionary where Key == Point, Value: MapElement {
  func print(invertedY: Bool, clearElement: Value) -> String {
    let minX = self.keys.min { (lhs, rhs) in lhs.x < rhs.x }!.x
    let maxX = self.keys.min { (lhs, rhs) in lhs.x > rhs.x }!.x
    let minY = self.keys.min { (lhs, rhs) in lhs.y < rhs.y }!.y
    let maxY = self.keys.min { (lhs, rhs) in lhs.y > rhs.y }!.y

    let yStride = invertedY ? stride(from: minY, through: maxY, by: 1) : stride(from: maxY, through: minY, by: -1)

    var result = ""
    for y in yStride {
      for x in minX...maxX {
        let element = self[Point(x: x, y: y)]
        result += element?.representation ?? clearElement.representation
      }

      result += "\n"
    }

    return result
  }
}
