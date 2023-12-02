// Created by Daniele Formichelli.

import Utils

/// https://adventofcode.com/2015/day/22
struct Year2015Day22: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    var min = Int.max
    return Self.minMana(bossStats: input.bossStats, hard: false, min: &min)
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    var min = Int.max
    return Self.minMana(bossStats: input.bossStats, hard: true, min: &min)
  }

  private static func minMana(
    bossStats: Stats,
    hard: Bool,
    ownTurn: Bool = true,
    ownHitPoints: Int = 50,
    remainingMana: Int = 500,
    spentMana: Int = 0,
    activeEffects: [SpellDetails: Int] = [:],
    currentTurn: Int = 0,
    min currentMin: inout Int
  ) -> Int {
    if spentMana > currentMin {
      return Int.max
    }

    var remainingOwnHitPoints = ownHitPoints
    var remainingBossHitPoints = bossStats.hitPoints
    var ownArmor = 0
    var updatedRemainingMana = remainingMana

    if hard, ownTurn {
      remainingOwnHitPoints -= 1
      guard remainingOwnHitPoints > 0 else {
        return Int.max
      }
    }

    activeEffects.filter { $0.value >= currentTurn }.keys.forEach { spell in
      remainingBossHitPoints -= spell.effectDamage
      ownArmor += spell.effectArmor
      updatedRemainingMana += spell.effectMana
    }

    guard remainingBossHitPoints > 0 else {
      let localMin = spentMana
      currentMin = min(currentMin, localMin)
      return localMin
    }

    let newActiveEffects = activeEffects.filter { $0.value > currentTurn }
    let availableSpells = Self.spells.filter { $0.cost <= updatedRemainingMana }.filter { newActiveEffects[$0] == nil }

    let localMin: Int
    if ownTurn {
      localMin = availableSpells
        .map { spell in
          let remainingBossHitPoints = remainingBossHitPoints - spell.damage
          let remainingOwnHitPoints = remainingOwnHitPoints + spell.heal
          let newSpentMana = spentMana + spell.cost
          var newActiveEffects = newActiveEffects

          guard remainingBossHitPoints > 0 else {
            return newSpentMana
          }

          newActiveEffects[spell] = currentTurn + spell.effectDuration
          return Self.minMana(
            bossStats: Stats(hitPoints: remainingBossHitPoints, damage: bossStats.damage, armor: bossStats.armor),
            hard: hard,
            ownTurn: !ownTurn,
            ownHitPoints: remainingOwnHitPoints,
            remainingMana: updatedRemainingMana - spell.cost,
            spentMana: newSpentMana,
            activeEffects: newActiveEffects,
            currentTurn: currentTurn + 1,
            min: &currentMin
          )
        }
        .min() ?? Int.max
    } else {
      let remainingOwnHitPoints = remainingOwnHitPoints - max(1, bossStats.damage - ownArmor)
      guard remainingOwnHitPoints > 0 else {
        return Int.max
      }

      localMin = Self.minMana(
        bossStats: Stats(hitPoints: remainingBossHitPoints, damage: bossStats.damage, armor: bossStats.armor),
        hard: hard,
        ownTurn: !ownTurn,
        ownHitPoints: remainingOwnHitPoints,
        remainingMana: updatedRemainingMana,
        spentMana: spentMana,
        activeEffects: newActiveEffects,
        currentTurn: currentTurn + 1,
        min: &currentMin
      )
    }

    currentMin = min(currentMin, localMin)
    return localMin
  }

  private static var spells: [SpellDetails] {
    return [
      .init(cost: 53, damage: 4, heal: 0, effectDuration: 0, effectDamage: 0, effectArmor: 0, effectMana: 0),
      .init(cost: 73, damage: 2, heal: 2, effectDuration: 0, effectDamage: 0, effectArmor: 0, effectMana: 0),
      .init(cost: 113, damage: 0, heal: 0, effectDuration: 6, effectDamage: 0, effectArmor: 7, effectMana: 0),
      .init(cost: 173, damage: 0, heal: 0, effectDuration: 6, effectDamage: 3, effectArmor: 0, effectMana: 0),
      .init(cost: 229, damage: 0, heal: 0, effectDuration: 5, effectDamage: 0, effectArmor: 0, effectMana: 101),
    ]
  }
}

private struct SpellDetails: Hashable {
  let cost: Int
  let damage: Int
  let heal: Int
  let effectDuration: Int
  let effectDamage: Int
  let effectArmor: Int
  let effectMana: Int
}

private struct Stats {
  let hitPoints: Int
  let damage: Int
  let armor: Int

  func damage(to other: Self) -> Int {
    return max(1, self.damage - other.armor)
  }
}

extension String {
  fileprivate var bossStats: Stats {
    let lines = self.lines
    let hitPoints = Int(lines[0].components(separatedBy: ": ")[1])!
    let damage = Int(lines[1].components(separatedBy: ": ")[1])!
    return Stats(hitPoints: hitPoints, damage: damage, armor: 0)
  }
}
