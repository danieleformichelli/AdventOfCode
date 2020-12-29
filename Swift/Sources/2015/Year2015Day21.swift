//
//  Year2015Day21.swift
//
//  Copyright © 2020 Bending Spoons. All rights reserved.
//

import Parsing
import Utils

/// https://adventofcode.com/2015/day/21
struct Year2015Day21: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    let bossStats = input.bossStats
    var minCost = Int.max
    for weapon in Self.weapons {
      for armor in Self.armors.union([.none]) {
        for ring in Self.rings.union([.none]) {
          for otherRing in Self.rings.union([.none]) {
            let stats = Stats(
              hitPoints: 100,
              damage: weapon.damage + armor.damage + ring.damage + otherRing.damage,
              armor: weapon.armor + armor.armor + ring.armor + otherRing.armor
            )

            if Self.battle(stats, versus: bossStats) {
              let cost = weapon.cost + armor.cost + ring.cost + otherRing.cost
              minCost = min(minCost, cost)
            }
          }
        }
      }
    }

    return minCost
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    let bossStats = input.bossStats
    var maxCost = 0
    for weapon in Self.weapons {
      for armor in Self.armors.union([.none]) {
        for ring in Self.rings.union([.none]) {
          for otherRing in Self.rings.union([.none]) {
            guard ring != otherRing else { continue }
            let stats = Stats(
              hitPoints: 100,
              damage: weapon.damage + armor.damage + ring.damage + otherRing.damage,
              armor: weapon.armor + armor.armor + ring.armor + otherRing.armor
            )

            if !Self.battle(stats, versus: bossStats) {
              let cost = weapon.cost + armor.cost + ring.cost + otherRing.cost
              maxCost = max(maxCost, cost)
            }
          }
        }
      }
    }

    return maxCost
  }

  private static func battle(_ first: Stats, versus second: Stats) -> Bool {
    let firstTurnsToKill = (second.hitPoints - 1) / first.damage(to: second) + 1
    let secondTurnsToKill = (first.hitPoints - 1) / second.damage(to: first) + 1
    return firstTurnsToKill <= secondTurnsToKill
  }

  private static var weapons: Set<ItemDetails> {
    return [
      .init(cost: 8, damage: 4, armor: 0),
      .init(cost: 10, damage: 5, armor: 0),
      .init(cost: 25, damage: 6, armor: 0),
      .init(cost: 40, damage: 7, armor: 0),
      .init(cost: 74, damage: 8, armor: 0)
    ]
  }

  private static var armors: Set<ItemDetails> {
    return [
      .init(cost: 13, damage: 0, armor: 1),
      .init(cost: 31, damage: 0, armor: 2),
      .init(cost: 53, damage: 0, armor: 3),
      .init(cost: 75, damage: 0, armor: 4),
      .init(cost: 102, damage: 0, armor: 5)
    ]
  }

  private static var rings: Set<ItemDetails> {
    return [
      .init(cost: 25, damage: 1, armor: 0),
      .init(cost: 50, damage: 2, armor: 0),
      .init(cost: 100, damage: 3, armor: 0),
      .init(cost: 20, damage: 0, armor: 1),
      .init(cost: 40, damage: 0, armor: 2),
      .init(cost: 80, damage: 0, armor: 3)
    ]
  }
}

fileprivate enum ItemType {
  case weapon
  case armor
  case ring
}

fileprivate struct ItemDetails: Hashable {
  let cost: Int
  let damage: Int
  let armor: Int

  static var none: Self {
    return .init(cost: 0, damage: 0, armor: 0)
  }
}


fileprivate struct Stats {
  let hitPoints: Int
  let damage: Int
  let armor: Int

  func damage(to other: Self) -> Int {
    return max(1, self.damage - other.armor)
  }
}

extension String {
  fileprivate var bossStats: Stats {
    let properties = Skip(StartsWith("Hit Points: "))
      .take(Int.parser())
      .skip(StartsWith("\nDamage: "))
      .take(Int.parser())
      .skip(StartsWith("\nArmor: "))
      .take(Int.parser())
      .map {
        return Stats(hitPoints: $0, damage: $1, armor: $2)
      }

    return properties.parse(self)!
  }
}

