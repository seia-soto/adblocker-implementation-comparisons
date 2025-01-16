import { comparisons } from "./comparisons/index.js"
import { sleep } from "./utils.js"

const [subject] = process.argv.slice(2)

if (subject in comparisons) {
  const comparison = comparisons[subject]
  console.log(`* Selected "${subject}"`)
  for (const [name, fn] of Object.entries(comparison)) {
    console.log(`* Cooling down for 5 seconds`)
    await sleep(5 * 1000)
    console.log(`* Running "${name}"`)
    console.log(await fn())
  }
} else {
  throw new Error(`"${subject}" is not a known comparison!`)
}
