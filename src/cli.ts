import { comparisons } from "./comparisons/index.js"
import { Options } from "./types.js"
import { sleep } from "./utils.js"

const argv = process.argv.slice(2)
const options: Options = {
  cycles: 100_000
}

let subject: string | undefined;
for (const arg of argv) {
  if (arg.startsWith('--')) {
    const [k, v] = arg.slice(2).split('=')
    switch (k) {
      case 'cycles': {
        const n = parseInt(v, 10)
        if (isNaN(n) || n <= 0) {
          throw new Error(`"${v}" is not a valid positive integer!`)
        }
        options.cycles = n;
        break;
      }
      default: 
        throw new Error(`"${k}" is not a known option!`)
    }
  } else {
    subject = arg
  }
}

if (typeof subject !== 'undefined' && subject in comparisons) {
  const comparison = comparisons[subject]
  console.log(`* Selected "${subject}"`)
  console.log(options)
  for (const [name, fn] of Object.entries(comparison)) {
    console.log(`* Cooling down for 5 seconds`)
    await sleep(5 * 1000)
    console.log(`* Running "${name}"`)
    console.log(await fn(options))
  }
} else {
  throw new Error(`"${subject}" is not a known comparison!`)
}
