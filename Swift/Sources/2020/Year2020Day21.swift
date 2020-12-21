//
//  Year2020Day21.swift
//  AdventOfCode2020
//
//  Created by Daniele Formichelli on 21/12/2020.
//  Copyright © 2020 Daniele Formichelli. All rights reserved.
//

import Foundation
import Utils

/// https://adventofcode.com/2020/day/21
public struct Year2020Day21: DayBase {
  public func part1(_ input: String) -> CustomDebugStringConvertible {
    let allIngredientsAndAllergens = input.ingredientsAndAllergens
    let ingredientsWithoutAllergens = self.run(allIngredientsAndAllergens).ingredientsWithoutAllergens
    return allIngredientsAndAllergens
      .map(\.ingredients)
      .map { $0.filter { ingredientsWithoutAllergens.contains($0) }.count }
      .sum
  }

  public func part2(_ input: String) -> CustomDebugStringConvertible {
    let allIngredientsAndAllergens = input.ingredientsAndAllergens
    let allergenToIngredient = self.run(allIngredientsAndAllergens).allergenToIngredient
    return allergenToIngredient.sorted { $0.key < $1.key }.map { $0.value }.joined(separator: ",")
  }

  private func run(
    _ allIngredientsAndAllergens: [IngredientsAndAllergens]
  ) -> (allergenToIngredient: [String: String], ingredientsWithoutAllergens: Set<String>) {
    let allIngredients: Set<String> = allIngredientsAndAllergens.flatMap { $0.ingredients }.asSet

    var ingredientsWithoutAllergens = allIngredients
    var allergenToIngredient: [String: String] = [:]
    var allergensToIngredients: [String: Set<String>] = allIngredientsAndAllergens.reduce(into: [:]) { result, ingredientsAndAllergens in
      for allergen in ingredientsAndAllergens.allergens {
        if let currentIngredients = result[allergen] {
          result[allergen] = currentIngredients.intersection(ingredientsAndAllergens.ingredients)
        } else {
          result[allergen] = ingredientsAndAllergens.ingredients
        }
      }
    }

    while !allergensToIngredients.isEmpty {
      let assignedIngredients = allergensToIngredients
        .filter { $0.value.count == 1 }
        .map { allergenToIngredients -> String in
          let allergen = allergenToIngredients.key
          let ingredient = allergenToIngredients.value.first!
          allergenToIngredient[allergen] = ingredient
          allergensToIngredients[allergen] = nil
          ingredientsWithoutAllergens.remove(ingredient)
          return ingredient
        }

      for ingredient in assignedIngredients {
        for remainingAllergen in allergensToIngredients.keys {
          allergensToIngredients[remainingAllergen]?.remove(ingredient)
        }
      }
    }

    return (allergenToIngredient: allergenToIngredient, ingredientsWithoutAllergens: ingredientsWithoutAllergens)
  }
}

extension Year2020Day21 {
  fileprivate struct IngredientsAndAllergens {
    let ingredients: Set<String>
    let allergens: Set<String>
  }
}

extension String {
  fileprivate var ingredientsAndAllergens: [Year2020Day21.IngredientsAndAllergens] {
    return self.lines.map { line in
      let ingredientsAndAllergens = line.components(separatedBy: " (contains ")
      return .init(
        ingredients: ingredientsAndAllergens[0].split(separator: " ").map(String.init).asSet,
        allergens: ingredientsAndAllergens[1].dropLast().components(separatedBy: ", ").asSet
      )
    }
  }
}
