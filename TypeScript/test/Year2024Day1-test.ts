import assert from "node:assert";
import { describe, it } from "node:test";
import { year2024Day1Part1, year2024Day1Part2 } from "../src/2024/Year2024Day1";

describe("Year2024Day1", () => {
  it("Part 1", () => {
    assert.equal(year2024Day1Part1(), "Year 2024 Day 1 Part 1");
  });

  it("Part 2", () => {
    assert.equal(year2024Day1Part2(), "Year 2024 Day 1 Part 2");
  });
});
