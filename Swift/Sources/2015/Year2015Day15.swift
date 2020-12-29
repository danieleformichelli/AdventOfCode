//
//  Year2015Day15.swift
//
//  Copyright © 2020 Bending Spoons. All rights reserved.
//

import Parsing
import Utils

/// https://adventofcode.com/2015/day/15
struct Year2015Day15: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    return Self.maxScore(ingredients: input.ingredients)
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    return input
  }

  private static func maxScore(
    ingredients: [Properties],
    teaspoons: Int = 100,
    properties: Properties = .init(capacity: 0, durability: 0, flavor: 0, texture: 0, calories: 0)
  ) -> Int {
    guard ingredients.count > 1 else {
      let ingredient = ingredients.first!
      return properties.add(teaspoons, of: ingredient).score
    }

    let firstIngredient = ingredients.first!
    let remainingIngredients = ingredients.dropFirst().asArray
    return (0 ... teaspoons)
      .map { i in
        Self.maxScore(
          ingredients: remainingIngredients,
          teaspoons: teaspoons - i,
          properties: properties.add(i, of: firstIngredient)
        )
      }
      .max()!
  }
}

fileprivate struct Properties {
  let capacity: Int
  let durability: Int
  let flavor: Int
  let texture: Int
  let calories: Int

  func add(_ teaspoons: Int, of properties: Properties) -> Self {
    return .init(
      capacity: self.capacity + teaspoons * properties.capacity,
      durability: self.durability + teaspoons * properties.durability,
      flavor: self.flavor + teaspoons * properties.flavor,
      texture: self.texture + teaspoons * properties.texture,
      calories: self.calories + teaspoons * properties.calories
    )
  }

  var score: Int {
    guard self.calories == 500 else {
      return 0
    }
    return max(0, self.capacity) * max(0, self.durability) * max(0, self.flavor) * max(0, self.texture)
  }
}

extension String {
  fileprivate var ingredients: [Properties] {
    let name = Prefix<Substring>(minLength: 0) { $0.isLetter }.map { $0.asString }
    let properties = Skip(name)
      .skip(StartsWith(": capacity "))
      .take(Int.parser())
      .skip(StartsWith(", durability "))
      .take(Int.parser())
      .skip(StartsWith(", flavor "))
      .take(Int.parser())
      .skip(StartsWith(", texture "))
      .take(Int.parser())
      .skip(StartsWith(", calories "))
      .take(Int.parser())
      .map {
        return Properties(capacity: $0, durability: $1, flavor: $2, texture: $3, calories: $4)
      }
    return Many(properties, separator: StartsWith("\n")).parse(self)!
  }
}
