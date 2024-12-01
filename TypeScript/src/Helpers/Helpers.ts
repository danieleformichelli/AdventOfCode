export function lines(input: string): string[] {
  return input.split("\n");
}
export function zip<L, R>(a: L[], b: R[]): [L, R][] {
  if (a.length !== b.length) {
    throw new Error(`Array lengths must match: ${JSON.stringify({ a, b })}`);
  }
  return a.map((k, i) => [k, b[i]!]);
}
