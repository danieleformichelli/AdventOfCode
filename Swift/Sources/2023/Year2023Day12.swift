// Created by Daniele Formichelli.

import Utils

/// https://adventofcode.com/2023/day/12
struct Year2023Day12: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    var cache: [Row: Int] = [:]
    return input.rows.map { Self.arrangments(for: $0, cache: &cache) }.sum as Int
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    var cache: [Row: Int] = [:]
    return input.rows.map { row in
      let springs: [Row.Spring] = row.springs + [.unknown] + row.springs + [.unknown] + row.springs + [.unknown] + row.springs + [.unknown] + row.springs
      let damaged = row.damaged + row.damaged + row.damaged + row.damaged + row.damaged
      print("\(row)")
      return Self.arrangments(for: Row(springs: springs, damaged: damaged), cache: &cache)
    }.sum as Int
    
  }
  
  static func arrangments(for row: Row, cache: inout [Row: Int]) -> Int {
    if let cached = cache[row] {
      print("cached!")
      return cached
    }
    guard let nextDamagedGroup = row.damaged.first else{
      let arrangments = row.springs.allSatisfy({ $0 != .damaged }) ? 1 : 0
      return arrangments
    }
    guard let nextNonOperational = row.springs.firstIndex(where: { $0 != .operational }) else {
      return 0
    }
    if row.damaged.sum + row.damaged.count - 1 > row.springs.count {
      return 0
    }

    let lastNextNonOperational = row.springs.dropFirst(nextNonOperational).firstIndex(where: { $0 == .operational })
    
    let nextGroupCount = (nextNonOperational ..< (lastNextNonOperational ?? row.springs.endIndex)).count
    let indexPicking = nextNonOperational + nextDamagedGroup
    let skipped = indexPicking < row.springs.count ? row.springs[indexPicking] : .operational
    let subRowPicking = Row(
      springs: indexPicking < row.springs.count ? row.springs[row.springs.index(after: indexPicking)...].asArray : [],
      damaged: row.damaged.dropFirst().asArray
    )
    let picking = nextGroupCount >= nextDamagedGroup && skipped != .damaged ? Self.arrangments(for: subRowPicking, cache: &cache) : 0
    let arrangments: Int
    switch row.springs[nextNonOperational] {
    case .damaged:
      arrangments = picking
    case .unknown:
      let indexSkipping = nextNonOperational
      let subRowSkipping = Row(
        springs: indexSkipping < row.springs.count ? row.springs[row.springs.index(after: indexSkipping)...].asArray : [],
        damaged: row.damaged
      )
      let skipping = Self.arrangments(for: subRowSkipping, cache: &cache)
      
      arrangments = picking + skipping
    case .operational:
      fatalError()
    }
    cache[row] = arrangments
    return arrangments
  }
}

struct Row: Hashable {
  enum Spring: String {
    case operational = "."
    case damaged = "#"
    case unknown = "?"
    
    var customDebugConvertible: String {
      return self.rawValue
    }
  }
  
  let springs: [Spring]
  let damaged: [Int]
}

extension String {
  fileprivate var rows: [Row] {
    return self.lines.map { line in
      let split = line.components(separatedBy: " ")
      let springs = split[0].map { spring in
        switch spring {
        case ".":
          return Row.Spring.operational
        case "#":
          return Row.Spring.damaged
        case "?":
          return Row.Spring.unknown
        default:
          fatalError()
        }
      }
      let damaged = split[1].commaSeparatedNumbers
      return .init(springs: springs, damaged: damaged)
    }
  }
}
