export type Options = {
  cycles: number;
}
export type Runs = Record<string, (options: Options) => Promise<unknown>>
export type Comparisons = Record<string, Runs>
