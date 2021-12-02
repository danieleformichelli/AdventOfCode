// Created by Daniele Formichelli.

import Utils

/// https://adventofcode.com/2020/day/7
public struct Year2020Day7: DayBase {
  static let shinyGold = "shiny gold"

  public func part1(_ input: String) -> CustomDebugStringConvertible {
    var cache: [String: Bool] = [:]
    let bagDetails = input.bagDetails

    return input.bagDetails.keys.filter { $0.canContainGold(bagDetails: bagDetails, cache: &cache) }.count
  }

  public func part2(_ input: String) -> CustomDebugStringConvertible {
    var cache: [String: Int] = [:]
    return Self.shinyGold.containedBags(bagDetails: input.bagDetails, cache: &cache) - 1
  }
}

extension String {
  fileprivate func canContainGold(bagDetails: [String: [String: Int]], cache: inout [String: Bool]) -> Bool {
    if let cached = cache[self] {
      return cached
    }

    let canContainDirectly = bagDetails[self]?[Year2020Day7.shinyGold] != nil
    let canContainInContainedBags = (bagDetails[self] ?? [:]).keys.asArray
      .contains { $0.canContainGold(bagDetails: bagDetails, cache: &cache) }
    let canContain = canContainDirectly || canContainInContainedBags
    cache[self] = canContain
    return canContain
  }

  fileprivate func containedBags(bagDetails: [String: [String: Int]], cache: inout [String: Int]) -> Int {
    guard let bagDetail = bagDetails[self],
          !bagDetail.isEmpty
    else {
      return 1
    }

    if let cached = cache[self] {
      return cached
    }

    let containedBags = bagDetail
      .map { bag, count in
        return count * bag.containedBags(bagDetails: bagDetails, cache: &cache)
      }
      .sum
    let totalBags = 1 + containedBags
    cache[self] = totalBags
    return totalBags
  }

  fileprivate var bagDetails: [String: [String: Int]] {
    Dictionary(uniqueKeysWithValues: self.split(separator: "\n").map { line in
      let colorAndDetails = line.dropLast(1).components(separatedBy: " bags contain ")
      let detailsString = colorAndDetails[1].components(separatedBy: ", ")
      let details = Dictionary(uniqueKeysWithValues: detailsString.compactMap { detail -> (String, Int)? in
        guard detail != "no other bags" else {
          return nil
        }
        let detailSplit = detail.split(separator: " ", maxSplits: 1)
        let count = Int(detailSplit[0])!
        let colorEndIndex = detailSplit[1].lastIndex(of: " ")!
        let color = String(detailSplit[1].prefix(upTo: colorEndIndex))
        return (color, count)
      })
      return (String(colorAndDetails[0]), details)
    })
  }
}
