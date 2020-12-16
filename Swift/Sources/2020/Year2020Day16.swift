//
//  Year2020Day16.swift
//  AdventOfCode2020
//
//  Created by Daniele Formichelli on 16/12/2020.
//  Copyright © 2020 Daniele Formichelli. All rights reserved.
//

import Utils

/// https://adventofcode.com/2020/day/16
public struct Year2020Day16: DayBase {
  public func part1(_ input: String) -> CustomDebugStringConvertible {
    return self.invalidValues(from: input.ticketsInfo).flatMap { $0 }.sum
  }

  public func part2(_ input: String) -> CustomDebugStringConvertible {
    let ticketsInfo = input.ticketsInfo
    let invalidValues = self.invalidValues(from: input.ticketsInfo)
    let validTickets =
      [ticketsInfo.myTicket] + ticketsInfo.nearbyTickets.enumerated().filter { invalidValues[$0.0].isEmpty }.map { $0.1 }
    var fieldIndex: [String: Int] = [:]
    var possibleFields: [Set<String>] = Array(repeating: ticketsInfo.fieldRanges.keys.asSet, count: ticketsInfo.myTicket.count)
    var remainingFields = ticketsInfo.fieldRanges
    while !remainingFields.isEmpty {
      for ticket in validTickets {
        for (index, value) in ticket.enumerated() {
          guard possibleFields[index].count != 1 else {
            // already determined index
            continue
          }

          // discard already fields
          possibleFields[index] = possibleFields[index]
            .intersection(remainingFields.keys)
            .filter { ticketsInfo.fieldRanges[$0]!.contains(value) }

          if possibleFields[index].count == 1 {
            let field = possibleFields[index].first!
            fieldIndex[field] = index
            remainingFields[field] = nil
          }
        }
      }
    }
    return fieldIndex
      .filter { $0.key.starts(with: "departure") }
      .map { ticketsInfo.myTicket[$0.value] }
      .multiply
  }

  private func invalidValues(from ticketsInfo: TicketsInfo) -> [Set<Int>] {
    return ticketsInfo
      .nearbyTickets
      .map { ticketValues in
        let invalidValues = ticketValues
          .filter { value in
            return !ticketsInfo.fieldRanges.values.contains(where: { $0.contains(value) })
          }
          .asSet
        return invalidValues
      }
  }
}

extension Year2020Day16 {
  fileprivate struct TicketsInfo {
    let fieldRanges: [String: Set<ClosedRange<Int>>]
    let myTicket: [Int]
    let nearbyTickets: [[Int]]
  }
}

extension String {
  fileprivate var ticketsInfo: Year2020Day16.TicketsInfo {
    let rangesAndTickets = self.components(separatedBy: "\n\nyour ticket:\n")
    let myTicketAndNearbyTickets = rangesAndTickets[1].components(separatedBy: "\n\nnearby tickets:\n")

    let fieldRanges: [String: Set<ClosedRange<Int>>] = Dictionary(uniqueKeysWithValues: rangesAndTickets[0].lines.map {
      let split = $0.components(separatedBy: ": ")
      let field = split[0]
      let ranges = split[1].components(separatedBy: " or ").map { range -> ClosedRange<Int> in
        let rangeSplit = range.split(separator: "-")
        return Int(rangeSplit[0])!...Int(rangeSplit[1])!
      }.asSet
      return (field, ranges)
    })

    return .init(
      fieldRanges: fieldRanges,
      myTicket: myTicketAndNearbyTickets[0].commaSeparatedNumbers,
      nearbyTickets: myTicketAndNearbyTickets[1].split(separator: "\n").map { String($0).commaSeparatedNumbers }
    )
  }
}

extension Set where Element == ClosedRange<Int> {
  func contains(_ value: Int) -> Bool {
    return self.contains { $0.contains(value) }
  }
}
