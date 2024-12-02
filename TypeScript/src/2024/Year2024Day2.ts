import { linesWithNumbers } from "../Helpers/Helpers.ts";

export function year2024Day2Part1(input: string) {
  return safeReports(input, false);
}

export function year2024Day2Part2(input: string) {
  return safeReports(input, true);
}

function safeReports(input: string, dampenUnsafe: boolean) {
  let safeReports = 0;
  for (const report of linesWithNumbers(input)) {
    if (isSafeReport(report, dampenUnsafe)) {
      safeReports++;
    }
  }
  return safeReports;
}

function isSafeReport(report: number[], dampenUnsafe: boolean): boolean {
  let wasIncreasing: boolean | undefined = undefined;
  let last: number | undefined = undefined;
  for (const [index, level] of report.entries()) {
    if (last === undefined) {
      last = level;
      continue;
    }
    const isIncreasing = level > last;
    if (wasIncreasing !== undefined && isIncreasing !== wasIncreasing) {
      if (dampenUnsafe) {
        return isSafeReportDampeningErrorAt(report, index);
      } else {
        return false;
      }
    }
    if (Math.abs(level - last) < 1 || Math.abs(level - last) > 3) {
      if (dampenUnsafe) {
        return isSafeReportDampeningErrorAt(report, index);
      } else {
        return false;
      }
    }

    wasIncreasing = isIncreasing;
    last = level;
  }
  return true;
}

function isSafeReportDampeningErrorAt(
  report: number[],
  index: number,
): boolean {
  return (
    isSafeReport(
      [...report.slice(0, index), ...report.slice(index + 1)],
      false,
    ) ||
    isSafeReport(
      [...report.slice(0, index - 1), ...report.slice(index)],
      false,
    ) ||
    (index > 1 &&
      isSafeReport(
        [...report.slice(0, index - 2), ...report.slice(index - 1)],
        false,
      ))
  );
}
