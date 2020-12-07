//
//  Year2019Day8.swift
//  AdventOfCode2019
//
//  Created by Daniele Formichelli on 08/12/2019.
//  Copyright © 2019 Daniele Formichelli. All rights reserved.
//

import Utils

/// https://adventofcode.com/2019/day/8
struct Year2019Day8: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    let targetLayer = input.image.layers.min { $0.count(color: .black) < $1.count(color: .black) }!
    return targetLayer.count(color: .white) * targetLayer.count(color: .clear)
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    input.image.print
  }
}

private extension Year2019Day8 {
  struct SpecialImageFormat {
    enum PixelColor: Character {
      case black = "0"
      case white = "1"
      case clear = "2"

      var representation: String {
        switch self {
        case .black, .clear:
          return "⬛️"
        case .white:
          return "⬜️"
        }
      }
    }

    struct Layer {
      static let width = 25
      static let height = 6
      var layerStr: String

      init(from layerStr: String) {
        self.layerStr = layerStr
      }

      subscript(row: Int, col: Int) -> PixelColor {
        let pixelIndex = row * Self.width + col
        let pixelCharacter = self.layerStr[self.layerStr.index(self.layerStr.startIndex, offsetBy: pixelIndex)]
        return PixelColor(rawValue: pixelCharacter)!
      }

      func count(color: PixelColor) -> Int {
        self.layerStr.filter { $0 == color.rawValue }.count
      }
    }

    let layers: [Layer]

    init(from pixelsStr: String) {
      let layerSize = Layer.width * Layer.height
      var layers: [Layer] = []

      var layerStartIndex = pixelsStr.startIndex
      let imageEndIndex = pixelsStr.endIndex
      while layerStartIndex < imageEndIndex {
        let layerEndIndex = pixelsStr.index(layerStartIndex, offsetBy: layerSize, limitedBy: imageEndIndex) ?? imageEndIndex
        layers.append(Layer(from: String(pixelsStr[layerStartIndex ..< layerEndIndex])))
        layerStartIndex = layerEndIndex
      }

      self.layers = layers
    }

    var print: String {
      var result: String = ""
      for row in 0 ..< Layer.height {
        for col in 0 ..< Layer.width {
          result += Self.getColor(for: self.layers, row: row, col: col).representation
        }
        if row != Layer.height - 1 {
          result += "\n"
        }
      }
      return result
    }

    private static func getColor(for layers: [Layer], row: Int, col: Int) -> PixelColor {
      let firstLayerWithNonTransparentPixel = layers.first { $0[row, col] != .clear }!
      return firstLayerWithNonTransparentPixel[row, col]
    }
  }
}

private extension String {
  var image: Year2019Day8.SpecialImageFormat {
    .init(from: self)
  }
}
