// Created by Daniele Formichelli.

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
    return self.lines.map {
      let nameSplit = $0.components(separatedBy: " can fly ")
      let name = nameSplit[0]
      let speedSplit = nameSplit[1].components(separatedBy: " km/s for ")
      let speed = Int(speedSplit[0])!
      let durationSplit = speedSplit[1].components(separatedBy: " seconds, but then must rest for ")
      let duration = Int(durationSplit[0])!
      let restSplit = durationSplit[1].components(separatedBy: " seconds.")
      let rest = Int(restSplit[0])!
      return Reindeer(name: name, speed: speed, duration: duration, rest: rest)
    }
  }
}
