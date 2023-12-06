// Created by Daniele Formichelli.

import Utils

/// https://adventofcode.com/2023/day/6
struct Year2023Day6: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    return Self.solve(races: input.races)
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    let (time, distance) = input.races.reduce((time: "", distance: ""), { result, race in
      (time: "\(result.0)\(race.time)", distance: "\(result.1)\(race.distance)")
    })
    return Self.solve(races: [(time: Int(time)!, distance: Int(distance)!)])
  }
  
  static func solve(races: [(time: Int, distance: Int)]) -> Int {
    return races.map { race in
      var wins = 0
      for i in 1 ..< race.time {
        let speed = i
        let remainingTime = race.time - i
        let distance = speed * remainingTime
        if distance > race.distance {
          wins += 1
        } else if wins > 0 {
          break
        }
      }
      return wins
    }.multiply
  }
}

extension String {
  fileprivate var races: [(time: Int, distance: Int)] {
    let lines = self.lines
    let times = lines[0].components(separatedBy: ":")[1].spaceSeparatedNumbers
    let distance = lines[1].components(separatedBy: ":")[1].spaceSeparatedNumbers
    return zip(times, distance).map { (time: $0, distance: $1) }
  }
}
