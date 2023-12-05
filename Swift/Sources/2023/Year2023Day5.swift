// Created by Daniele Formichelli.

import Utils

/// https://adventofcode.com/2023/day/5
struct Year2023Day5: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    let almanac = input.almanac
    return Self.solve(seeds: almanac.seeds.map { Almanac.MapKey(from: $0, to: $0 + 1) }, maps: almanac.maps)
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    let almanac = input.almanac
    var actualSeeds: [Almanac.MapKey] = []
    for index in stride(from: 0, to: almanac.seeds.count, by: 2) {
      actualSeeds.append(Almanac.MapKey(from: almanac.seeds[index], to: almanac.seeds[index] + almanac.seeds[index + 1] - 1))
    }
    return Self.solve(seeds: actualSeeds, maps: almanac.maps)
  }
  
  static func solve(seeds: [Almanac.MapKey], maps: [[Almanac.MapEntry]]) -> Int {
    var current = seeds
    maps.forEach { map in
      print(current)
      current = current.flatMap { Self.mapRange($0, map: map) }
    }
    return current.min { $0.from < $1.from }!.from
  }
  
  static func mapRange(_ values: Almanac.MapKey, map: [Almanac.MapEntry]) -> [Almanac.MapKey] {
    if let mapMatch = map.first(where: { Self.matches(values, mapEntry: $0)}) {
      let matchFrom = max(values.from, mapMatch.key.from)
      let before = matchFrom != values.from ? [Almanac.MapKey(from: values.from, to: matchFrom)] : []
      let matchTo = min(values.to, mapMatch.key.to)
      let mappedMatch = Almanac.MapKey(from: Self.mapValue(values.from, mapEntry: mapMatch), to: Self.mapValue(matchTo, mapEntry: mapMatch))
      let remainingMatch = matchTo != values.to ? Self.mapRange(Almanac.MapKey(from: matchTo, to: values.to), map: map) : []
      return before + [mappedMatch] + remainingMatch
    } else {
      return [values]
    }
  }
  
  static func matches(_ values: Almanac.MapKey, mapEntry: Almanac.MapEntry) -> Bool {
    return mapEntry.key.from < values.to && mapEntry.key.to > values.from
  }
  
  static func mapValue(_ number: Int, mapEntry: Almanac.MapEntry) -> Int {
    return mapEntry.value + number - mapEntry.key.from
  }
}

struct Almanac {
  struct MapKey: Hashable {
    let from: Int
    let to: Int
  }
  struct MapEntry: Hashable {
    let key: MapKey
    let value: Int
  }
  let seeds: [Int]
  let maps: [[MapEntry]]
}

extension String {
  fileprivate var almanac: Almanac {
    let lines = self.groupedLines
    let seeds = lines[0][0].components(separatedBy: ": ")[1].spaceSeparatedNumbers
    let maps = lines.dropFirst().map { mapLines in
      return mapLines
        .dropFirst().map { mapLine in
          let split = mapLine.spaceSeparatedNumbers
          return Almanac.MapEntry(key: Almanac.MapKey(from: split[1], to: split[1] + split[2]), value: split[0])
        }
        .sorted { $0.key.from < $1.key.to }
    }
    return Almanac(seeds: seeds, maps: maps)
  }
}
