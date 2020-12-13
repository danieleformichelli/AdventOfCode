//
//  Year2020Day13.swift
//  AdventOfCode2020
//
//  Created by Daniele Formichelli on 13/12/2020.
//  Copyright © 2020 Daniele Formichelli. All rights reserved.
//

import Utils

/// https://adventofcode.com/2020/day/13
public struct Year2020Day13: DayBase {
  public func part1(_ input: String) -> CustomDebugStringConvertible {
    let lines = input.lines
    let earliestDeparture = Int(lines[0])!
    let busIDs = lines[1].commaSeparatedNumbers.sorted()
    let startsAfterEarliestDeparture = busIDs.map { $0 - earliestDeparture % $0 }
    let (earliestStartIndex, earliestStartWait) = startsAfterEarliestDeparture.enumerated().min { $0.1 < $1.1 }!
    let firstBusID = busIDs[earliestStartIndex]
    return firstBusID * earliestStartWait
  }

  public func part2(_ input: String) -> CustomDebugStringConvertible {
    let split =  input.lines[1].components(separatedBy: ",")
    let firstBusID = Int(split[0])!
    var intervalAndBusID: [(interval: Int, busID: Int)] = [(interval: 0, busID: firstBusID)]
    var interval = 0
    for splitElement in split.dropFirst() {
      interval += 1
      if let busID = Int(splitElement) {
        intervalAndBusID.append((interval: interval, busID: busID))
      }
    }
    intervalAndBusID = intervalAndBusID.sorted { $0.busID < $1.busID }
    let max = intervalAndBusID.last!
    intervalAndBusID = intervalAndBusID.map { (interval: $0.interval - max.interval, busID: $0.busID) }

    var step = 0
    var stepElements = 0
    var earliestDeparture = 0
    while !intervalAndBusID.allSatisfy({ (earliestDeparture + $0.interval).isMultiple(of: $0.busID) }) {
      stepElements += 1
      let considered = intervalAndBusID.dropFirst(intervalAndBusID.count - stepElements - 1)
      step = Utils.lcm(intervalAndBusID.dropFirst(intervalAndBusID.count - stepElements).map { $0.busID })
      earliestDeparture += step
      while !considered.allSatisfy({ (earliestDeparture + $0.interval).isMultiple(of: $0.busID) }) {
        earliestDeparture += step
      }
    }

    return earliestDeparture + intervalAndBusID.map { $0.interval }.min()!
  }
}
