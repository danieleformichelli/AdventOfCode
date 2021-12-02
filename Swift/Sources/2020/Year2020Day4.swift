// Created by Daniele Formichelli.

import Utils

/// https://adventofcode.com/2020/day/4
struct Year2020Day4: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    input.asPassports.filter { $0.isPassport || $0.isNorthPoleCredentials }.count
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    input.asPassports.filter(\.isValidDocument).count
  }
}

extension Character {
  var isAlphanumeric: Bool {
    let allowed: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f"]
    return allowed.contains(self)
  }
}

extension Year2020Day4 {
  struct Passport {
    enum Field: String, CaseIterable {
      case birthYear = "byr"
      case issueYear = "iyr"
      case expirationYear = "eyr"
      case height = "hgt"
      case hairColor = "hcl"
      case eyeColor = "ecl"
      case passportID = "pid"
      case countryID = "cid"
    }

    let fields: [Field: String]

    var isPassport: Bool {
      self.fields.count == Field.allCases.count
    }

    var isNorthPoleCredentials: Bool {
      self.fields.count == Field.allCases.count - 1 && self.fields[.countryID] == nil
    }

    var isValidDocument: Bool {
      guard self.isPassport || self.isNorthPoleCredentials else {
        return false
      }

      return self.fields.allSatisfy { field, value in
        switch field {
        case .birthYear:
          guard let birthYear = Int(value) else { return false }
          return birthYear >= 1920 && birthYear <= 2002
        case .issueYear:
          guard let issueYear = Int(value) else { return false }
          return issueYear >= 2010 && issueYear <= 2020
        case .expirationYear:
          guard let expirationYear = Int(value) else { return false }
          return expirationYear >= 2020 && expirationYear <= 2030
        case .height:
          let unitLength = 2
          let unit = value.suffix(unitLength)
          guard let heightInUnit = Int(value.dropLast(unitLength)) else { return false }
          switch unit {
          case "cm":
            return heightInUnit >= 150 && heightInUnit <= 193
          case "in":
            return heightInUnit >= 59 && heightInUnit <= 76
          default:
            return false
          }
        case .hairColor:
          return value.first == "#" && value.dropFirst().allSatisfy(\.isAlphanumeric)
        case .eyeColor:
          let allowed = ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]
          return allowed.contains(value)
        case .passportID:
          return value.count == 9 && value.allSatisfy(\.isNumber)
        case .countryID:
          return true
        }
      }
    }
  }
}

extension String {
  fileprivate var asPassports: [Year2020Day4.Passport] {
    components(separatedBy: "\n\n")
      .compactMap { passportInput in
        var fields: [Year2020Day4.Passport.Field: String] = [:]
        var remaining = Substring(passportInput)
        while !remaining.isEmpty {
          let keyString = remaining.prefix(while: { $0 != ":" })
          remaining = remaining.dropFirst(keyString.count + 1)
          let value = remaining.prefix(while: { $0 != " " && $0 != "\n" })
          remaining = remaining.dropFirst(value.count + 1)
          let key = Year2020Day4.Passport.Field(rawValue: String(keyString))!
          fields[key] = String(value)
        }
        return .init(fields: fields)
      }
  }
}
