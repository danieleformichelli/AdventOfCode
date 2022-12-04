// Created by Daniele Formichelli.

import Utils

/// https://adventofcode.com/2022/day/3
struct Year2022Day3: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    let result = input.rucksacks
      .map { first, second in
        for element in first {
          if second.contains(element) {
            return element
          }
        }
        fatalError("no element found in both compartments")
      }
      .sum
    return result
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    let rucksacks = input.rucksacks
    var elements: [Int] = []
    for i in stride(from: 0, to: rucksacks.count, by: 3) {
      let first = rucksacks[i].first.union(rucksacks[i].second)
      let second = rucksacks[i + 1].first.union(rucksacks[i + 1].second)
      let third = rucksacks[i + 2].first.union(rucksacks[i + 2].second)
      for element in first {
        if second.contains(element) && third.contains(element) {
          elements.append(element)
          break
        }
      }
    }
    return elements.sum
  }
}

extension String {
  var rucksacks: [(first: Set<Int>, second: Set<Int>)] {
    return self.lines.map { line in
      func toCompartment(elements: Substring) -> Set<Int> {
        return elements.map { element in
          if element.asciiValue! <= Character("Z").asciiValue! {
            return Int(element.asciiValue! - Character("A").asciiValue! + 27)
          } else {
            return Int(element.asciiValue! - Character("a").asciiValue! + 1)
          }
        }.asSet
      }
      let items = line.count
      return (first: toCompartment(elements: line.prefix(items / 2)), second: toCompartment(elements: line.suffix(items / 2)))
    }
  }
}
