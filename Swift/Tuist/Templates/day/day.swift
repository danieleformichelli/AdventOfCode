import Foundation
import ProjectDescription

let year = Template.Attribute.optional("year", default: "2021")
let day = Template.Attribute.optional("day", default: "\(Calendar.current.ordinality(of: .day, in: .month, for: Date())!)")

let template = Template(
    description: "Day",
    attributes: [year, day],
    items: [
        .string(
            path: "Sources/\(year)/Year\(year)Day\(day).swift",
            contents: """
            // Created by Daniele Formichelli.

            import Utils

            /// https://adventofcode.com/\(year)/day/\(day)
            struct Year\(year)Day\(day): DayBase {
              func part1(_ input: String) -> CustomDebugStringConvertible {
                return 0
              }

              func part2(_ input: String) -> CustomDebugStringConvertible {
                return 0
              }
            }

            extension Year\(year)Day\(day) {
              struct Input {
                let value: Int
              }
            }

            extension String {
              var parsedInput: [Year\(year)Day\(day).Input] {
                self.lines.map { line in
                  return .init(value: Int(line)!)
                }
              }
            }
            """
        ),
        .string(
            path: "Tests/\(year)/Year\(year)Day\(day).swift",
            contents: """
            // Created by Daniele Formichelli.

            import XCTest
            @testable import AdventOfCode\(year)

            class Year\(year)Day\(day)Tests: XCTestCase {
              func testPart1() {
                XCTAssertEqual(Year\(year)Day\(day)().part1(Self.input).debugDescription, "0")
              }

              func testPart2() {
                XCTAssertEqual(Year\(year)Day\(day)().part2(Self.input).debugDescription, "0")
              }

              static var input: String {
                \"""
                \"""
              }
            }
            """
        ),
    ]
)
