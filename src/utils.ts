export function sleep(ms: number) {
  return new Promise<void>(resolve => setTimeout(() => resolve(), ms))
}

export function timings(start: number, end: number, cycle: number, operations: number) {
  const duration = end - start
  const durationPerCycle = duration / cycle
  const durationPerOperation = duration / cycle / operations

  return {
    duration,
    durationPerCycle,
    durationPerOperation
  }
}
