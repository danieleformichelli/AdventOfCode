// Created by Daniele Formichelli.

import Parsing
import Utils

/// https://adventofcode.com/2016/day/4
struct Year2016Day4: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    return input.rooms.filter(\.isValid).map(\.sector).sum
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    return input.rooms
      .filter { $0.isValid && $0.decryptedName == "northpole object storage " }
      .map(\.sector)
      .first!
  }
}

private struct Room {
  let name: String
  let sector: Int
  let checksum: String

  var decryptedName: String {
    return self.name
      .map { character in
        guard character.isLetter else { return " " }

        let asciiA = Int(Character("a").asciiValue!)
        let asciiZ = Int(Character("z").asciiValue!)
        let asciiChar = Int(character.asciiValue!)
        let decryptedAscii = UInt8(asciiA + (asciiChar - asciiA + self.sector) % (asciiZ - asciiA + 1))
        return Character(UnicodeScalar(decryptedAscii))
      }
      .asString
  }

  var isValid: Bool {
    var charCount: [Character: Int] = [:]
    for char in self.name {
      charCount[char] = charCount[char, default: 0] + 1
    }

    let validChecksum = charCount
      .filter(\.key.isLetter)
      .sorted {
        if $0.value != $1.value {
          return $0.value > $1.value
        } else {
          return $0.key < $1.key
        }
      }
      .map(\.0)
      .prefix(5)
      .asString

    return validChecksum == self.checksum
  }
}

extension String {
  fileprivate var rooms: [Room] {
    return self.lines.map { line in
      let splitIndex = line.lastIndex(of: "-")!
      let name = String(line[...splitIndex])
      let split = String(line[line.index(after: splitIndex)...]).components(separatedBy: "[")
      let sector = Int(split[0])!
      let checksum = String(split[1].dropLast())
      return Room(name: name, sector: sector, checksum: checksum)
    }
  }
}
