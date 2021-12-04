// Created by Daniele Formichelli.

import Utils

/// https://adventofcode.com/2021/day/3
struct Year2021Day3: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    let lines = input.lines
    let ones: [Int: Int] = lines.reduce(into: [:]) { result, line in
      line.enumerated().forEach { index, number in
        if number == "1" {
          result[index] = result[index, default: 0] + 1
        }
      }
    }

    var gamma = 0
    var epsilon = 0
    let bits = lines[0].count
    let threshold = lines.count / 2
    for i in 0 ..< bits {
      let bitValue = 1 << (bits - 1 - i)
      if ones[i] ?? 0 > threshold {
        gamma += bitValue
      } else {
        epsilon += bitValue
      }
    }
    return gamma * epsilon
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    let oxygen = Self.filter(lines: input.lines, keepMostCommon: true)
    let co2 = Self.filter(lines: input.lines, keepMostCommon: false)
    return Self.toDec(bin: oxygen) * Self.toDec(bin: co2)
  }

  private static func toDec(bin: String) -> Int {
    let bits = bin.count
    return bin.enumerated().reduce(0) { result, indexAndBit in
      let bitValue = (indexAndBit.1 == "1" ? 1 : 0) << (bits - 1 - indexAndBit.0)
      return result + bitValue
    }
  }

  private static func filter(lines: [String], keepMostCommon: Bool, index: Int = 0) -> String {
    guard lines.count > 1 else {
      return lines[0]
    }

    let onesCount = lines.reduce(into: 0) { result, line in
      let index = line.index(line.startIndex, offsetBy: index)
      if line[index] == "1" {
        result += 1
      }
    }
    let keep: String
    // +1 to handle rounding of odd numbers
    let threshold = (lines.count + 1) / 2
    if keepMostCommon {
      keep = onesCount >= threshold ? "1" : "0"
    } else {
      keep = onesCount < threshold ? "1" : "0"
    }

    let remainingLines = lines.filter { line in
      let index = line.index(line.startIndex, offsetBy: index)
      let value = String(line[index])
      return keep == value
    }

    return Self.filter(lines: remainingLines, keepMostCommon: keepMostCommon, index: index + 1)
  }
}
