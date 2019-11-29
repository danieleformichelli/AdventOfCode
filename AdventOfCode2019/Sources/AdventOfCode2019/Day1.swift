struct Day1: DayBase {
  func part1(input: String) -> String {
    return Utils.readLines(from: input)[0]
  }

  func part2(input: String) -> String {
    return Utils.readLines(from: input)[1]
  }
}
