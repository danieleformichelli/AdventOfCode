import { lines, zip } from "../Helpers/Helpers.ts";

export function year2024Day1Part1(input: string) {
  let { left, right } = lists(input);
  left = left.sort();
  right = right.sort();
  return zip(left, right).reduce((acc, [l, r]) => acc + Math.abs(l - r), 0);
}

export function year2024Day1Part2(input: string) {
  let { left, right } = lists(input);
  const rightCount = new Map<number, number>();
  for (const n of right) {
    rightCount.set(n, (rightCount.get(n) ?? 0) + 1);
  }
  return left.reduce((acc, l) => acc + l * (rightCount.get(l) ?? 0), 0);
}

function lists(input: string): { left: number[]; right: number[] } {
  const left: number[] = [];
  const right: number[] = [];
  for (const line of lines(input)) {
    const split = line.split("   ");
    left.push(Number(split[0]));
    right.push(Number(split[1]));
  }
  return { left, right };
}
