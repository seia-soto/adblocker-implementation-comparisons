import { readFileSync } from "node:fs";
import { join } from "node:path";
import { Runs } from "../../types.js";

function fetchAssets(): string[] {
  if (typeof window !== 'undefined') {
    throw new Error('Browser environment is not supported!')
  } else {
    return readFileSync(join(process.cwd(), './data/filters.txt'), 'utf8').split('\n')
  }
}

// https://github.com/ghostery/adblocker/blob/master/packages/adblocker/src/utils.ts#L68
// https://jsperf.com/string-startswith/21
function fastStartsWith(haystack: string, needle: string): boolean {
  if (haystack.length < needle.length) {
    return false;
  }

  const ceil = needle.length;
  for (let i = 0; i < ceil; i += 1) {
    if (haystack[i] !== needle[i]) {
      return false;
    }
  }

  return true;
}

export const compareStartsWith: Runs = {
  useFastStartsWith: async () => {
    const lines = fetchAssets()
    const time = Date.now()
    for (const line of lines) {
      for (let i = 0; i < line.length; i++) {
        fastStartsWith(line, line.slice(0, i))
      }
    }
    return {
      duration: Date.now() - time,
      sample: {
        lines: lines.length,
        size: lines.join('\n').length
      }
    }
  },
  useNativeStartsWith: async () => {
    const lines = fetchAssets()
    const time = Date.now()
    for (const line of lines) {
      for (let i = 0; i < line.length; i++) {
        line.startsWith(line.slice(0, i))
      }
    }
    return {
      duration: Date.now() - time,
      sample: {
        lines: lines.length,
        size: lines.join('\n').length
      }
    }
  }
}
