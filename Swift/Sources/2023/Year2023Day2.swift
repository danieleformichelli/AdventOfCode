// Created by Daniele Formichelli.

import Utils

/// https://adventofcode.com/2023/day/2
struct Year2023Day2: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    return input.games.enumerated().map { index, game in
      for cubes in game {
        if cubes.blue > 14 || cubes.red > 12 || cubes.green > 13 {
          return 0
        }
      }
      return index + 1
    }.sum as Int
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    return input.games.enumerated().map { index, game in
      var blue = 0
      var red = 0
      var green = 0
      for cubes in game {
        blue = max(blue, cubes.blue)
        red = max(red, cubes.red)
        green = max(green, cubes.green)
      }
      return blue * red * green
    }.sum as Int
  }
}

struct Cubes {
  let blue: Int
  let red: Int
  let green: Int
}

extension String {
  var games: [[Cubes]] {
    return self.lines.map {
      let split = $0.components(separatedBy: ": ")
      let sets = split[1].components(separatedBy: "; ")
      return sets.map { set in
        let cubes = set.components(separatedBy: ", ")
        var blue: Int = 0
        var red: Int = 0
        var green: Int = 0
        for cube in cubes {
          let split = cube.components(separatedBy: " ")
          switch split[1] {
          case "blue":
            blue = Int(split[0])!
          case "red":
            red = Int(split[0])!
          case "green":
            green = Int(split[0])!
          default:
            fatalError("Unknown color \(split[1])")
          }
        }
        return Cubes(blue: blue, red: red, green: green)
      }
    }
  }
}
