// Created by Daniele Formichelli.

import Utils

/// https://adventofcode.com/2015/day/15
struct Year2015Day15: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    return Self.maxScore(ingredients: input.ingredients, requiredCalories: nil)
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    return Self.maxScore(ingredients: input.ingredients, requiredCalories: 500)
  }

  private static func maxScore(
    ingredients: [Properties],
    requiredCalories: Int?,
    teaspoons: Int = 100,
    properties: Properties = .init(capacity: 0, durability: 0, flavor: 0, texture: 0, calories: 0)
  ) -> Int {
    guard ingredients.count > 1 else {
      let ingredient = ingredients.first!
      return properties.add(teaspoons, of: ingredient).score(requiredCalories: requiredCalories)
    }

    let firstIngredient = ingredients.first!
    let remainingIngredients = ingredients.dropFirst().asArray
    return (0 ... teaspoons)
      .map { i in
        Self.maxScore(
          ingredients: remainingIngredients,
          requiredCalories: requiredCalories,
          teaspoons: teaspoons - i,
          properties: properties.add(i, of: firstIngredient)
        )
      }
      .max()!
  }
}

private struct Properties {
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

  func score(requiredCalories: Int?) -> Int {
    if let requiredCalories = requiredCalories, self.calories != requiredCalories {
      return 0
    }
    return max(0, self.capacity) * max(0, self.durability) * max(0, self.flavor) * max(0, self.texture)
  }
}

extension String {
  fileprivate var ingredients: [Properties] {
    return self.lines.map {
      let split = $0.components(separatedBy: ": ")
      let properties = split[1].components(separatedBy: ", ")
      var capacity: Int = 0
      var durability: Int = 0
      var flavor: Int = 0
      var texture: Int = 0
      var calories: Int = 0
      for property in properties {
        let split = property.components(separatedBy: " ")
        let value = Int(split[1])!
        switch split[0] {
        case "capacity":
          capacity = value
        case "durability":
          durability = value
        case "flavor":
          flavor = value
        case "texture":
          texture = value
        case "calories":
          calories = value
        default:
          fatalError("Unknown property \(split[0])")
        }
      }
      return Properties(capacity: capacity, durability: durability, flavor: flavor, texture: texture, calories: calories)
    }
  }
}
