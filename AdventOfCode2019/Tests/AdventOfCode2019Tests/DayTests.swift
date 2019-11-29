import Quick
import Nimble
@testable import AdventOfCode2019

class DayTests: QuickSpec {
  var day: DayBase {
    fatalError("day must be overridden")
  }

  var part1Result: String {
    fatalError("part1Result must be overridden")
  }

  var part2Result: String {
    fatalError("part2Result must be overridden")
  }

  var input: String {
    fatalError("input must be overridden")
  }

  var part2Input: String {
    return self.input
  }

  override func spec() {
    describe("Day1") {
      it("Part1") {
        expect(self.day.part1(input: self.input)) == self.part1Result
      }

      it("Part2") {
        expect(self.day.part2(input: self.part2Input)) == self.part2Result
      }
    }
  }
}
