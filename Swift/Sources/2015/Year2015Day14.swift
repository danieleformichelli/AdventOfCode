// Created by Daniele Formichelli.

import Parsing
import Utils

/// https://adventofcode.com/2015/day/14
struct Year2015Day14: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    return input.reindeers.map { $0.distance(after: 2503) }.max()!
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    let reindeers = input.reindeers
    var score: [String: Int] = [:]
    for second in 1 ... 2503 {
      let distances = reindeers.map { ($0, $0.distance(after: second)) }
      let maxDistance = distances.max { $0.1 < $1.1 }!.1
      for winner in distances.filter({ $0.1 == maxDistance }).map(\.0) {
        score[winner.name] = score[winner.name, default: 0] + 1
      }
    }
    return score.values.max()!
  }
}

private struct Reindeer {
  let name: String
  let speed: Int
  let duration: Int
  let rest: Int

  var cycle: Int {
    return self.duration + self.rest
  }

  func distance(after seconds: Int) -> Int {
    let cycles = seconds / self.cycle
    let remainingSeconds = seconds % self.cycle
    let lastCycleMovingDuration = min(remainingSeconds, self.duration)
    return (cycles * self.duration + lastCycleMovingDuration) * self.speed
  }
}

extension String {
  fileprivate var reindeers: [Reindeer] {
    let name = Prefix<Substring>(minLength: 0) { $0.isLetter }.map(\.asString)
    let reindeer = name
      .skip(StartsWith(" can fly "))
      .take(Int.parser())
      .skip(StartsWith(" km/s for "))
      .take(Int.parser())
      .skip(StartsWith(" seconds, but then must rest for "))
      .take(Int.parser())
      .skip(StartsWith(" seconds."))
      .map {
        return Reindeer(name: $0, speed: $1, duration: $2, rest: $3)
      }
    return Many(reindeer, separator: StartsWith("\n")).parse(self)!
  }
}
