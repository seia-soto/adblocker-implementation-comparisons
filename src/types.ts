export type Runs = Record<string, () => Promise<unknown>>
export type Comparisons = Record<string, Runs>
