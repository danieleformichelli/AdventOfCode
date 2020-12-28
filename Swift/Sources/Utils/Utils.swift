//
//  Utils.swift
//  AdventOfCode2019
//
//  Created by Daniele Formichelli on 15/12/2019.
//  Copyright © 2019 Daniele Formichelli. All rights reserved.
//

import CommonCrypto
import Foundation

extension Int: CustomDebugStringConvertible {
  public var debugDescription: String {
    String(self)
  }
}

extension Int64: CustomDebugStringConvertible {
  public var debugDescription: String {
    String(self)
  }
}

public extension String {
  var lines: [String] {
    components(separatedBy: "\n")
  }

  var numbers: [Int] {
    components(separatedBy: "\n").compactMap { Int($0) }
  }

  var commaSeparatedNumbers: [Int] {
    components(separatedBy: ",").compactMap { Int($0) }
  }

  var commaSeparatedLines: [[String]] {
    components(separatedBy: "\n").compactMap { $0.components(separatedBy: ",") }
  }

  var intCodeMemory: [Int64: Int64] {
    var pairs = Array(commaSeparatedNumbers.enumerated().map { (Int64($0.offset), Int64($0.element)) })
    // store relative base at address -1
    pairs.append((IntCode.relativeBaseAddress, 0))
    return Dictionary(uniqueKeysWithValues: pairs)
  }

  var operations: [Operation] {
    return self.split(separator: "\n").map { .init(from: String($0)) }
  }
}

public protocol MapElement {
  var representation: String { get }
}

public struct Point: Hashable {
  public let x: Int
  public let y: Int

  public init(x: Int, y: Int) {
    self.x = x
    self.y = y
  }

  public func manhattanDistance(from other: Point) -> Int {
    abs(self.x - other.x) + abs(self.y - other.y)
  }

  public func move(_ direction: Direction) -> Point {
    return Point(x: self.x + direction.dx, y: self.y + direction.dy)
  }

  public static let zero: Point = .zero
}

public extension Dictionary where Key == Point, Value: MapElement {
  func print(invertedY: Bool, clearElement: Value) -> String {
    let minX = keys.min { lhs, rhs in lhs.x < rhs.x }!.x
    let maxX = keys.min { lhs, rhs in lhs.x > rhs.x }!.x
    let minY = keys.min { lhs, rhs in lhs.y < rhs.y }!.y
    let maxY = keys.min { lhs, rhs in lhs.y > rhs.y }!.y

    let yStride = invertedY ? stride(from: minY, through: maxY, by: 1) : stride(from: maxY, through: minY, by: -1)

    var result = ""
    for y in yStride {
      for x in minX ... maxX {
        let element = self[Point(x: x, y: y)]
        result += element?.representation ?? clearElement.representation
      }

      result += "\n"
    }

    return result
  }
}

public enum Utils {
  public static func gcd<T: FixedWidthInteger>(_ m: T, _ n: T) -> T {
    if m == n {
      return m
    } else if m == 0 {
      return n
    } else if n == 0 {
      return m
    }

    if m & 1 == 0 {
      // m is even
      if n & 1 == 1 {
        // and n is odd
        return self.gcd(m >> 1, n)
      } else {
        // both m and n are even
        return self.gcd(m >> 1, n >> 1) << 1
      }
    } else if n & 1 == 0 {
      // m is odd, n is even
      return self.gcd(m, n >> 1)
    } else if m > n {
      // reduce larger argument
      return self.gcd((m - n) >> 1, n)
    } else {
      // reduce larger argument
      return self.gcd((n - m) >> 1, m)
    }
  }

  public static func lcm<T: FixedWidthInteger>(_ m: T, _ n: T) -> T {
    m / self.gcd(m, n) * n
  }

  public static func lcm<T: FixedWidthInteger>(_ numbers: [T]) -> T {
    var lcmPartial: T = 1
    numbers.forEach { lcmPartial = Self.lcm(lcmPartial, $0) }
    return lcmPartial
  }
}

public extension Collection where Element: Numeric {
  var sum: Element {
    reduce(0, +)
  }
}

public extension Collection where Element: Numeric {
  var multiply: Element {
    reduce(1, *)
  }
}

public extension Collection {
  var asArray: [Element] {
    Array(self)
  }
}

public extension Collection where Element: Hashable {
  var asSet: Set<Element> {
    Set(self)
  }
}

public extension Substring {
  var asString: String {
    return String(self)
  }
}

public extension String {
  var md5: String {
    let data = Data(self.utf8)
    return data
      .withUnsafeBytes { bytes -> [UInt8] in
        var hash: [UInt8] = .init(repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        CC_MD5(bytes.baseAddress, CC_LONG(data.count), &hash)
        return hash
      }
      .map { String(format: "%02x", $0) }.joined()
  }
}
