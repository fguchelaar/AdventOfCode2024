import AdventKit
import Foundation

class Puzzle: Solvable {
    let memory: String

    required init(input: String) {
        memory = input
    }

    func part1() -> Int {
        guard #available(macOS 13.0, *) else {
            fatalError()
        }

        let search = /mul\((\d+),(\d+)\)/
        return memory.matches(of: search).map {
            Int($0.output.1)! * Int($0.output.2)!
        }
        .reduce(0, +)
    }

    func part2() -> Int {
        guard #available(macOS 13.0, *) else {
            fatalError()
        }

        var isActive = true
        let merged = memory.components(separatedBy: .whitespacesAndNewlines).joined()

        let dontRE = /don't\(\)/
        let doRE = /do\(\)/
        let mulRE = /mul\((\d+),(\d+)\)/

        var result = 0
        for index in merged.indices {
            let sub = merged[index...]
            if sub.starts(with: dontRE) {
                isActive = false
            } else if sub.starts(with: doRE) {
                isActive = true
            } else if isActive, let match = sub.prefixMatch(of: mulRE) {
                result += Int(match.output.1)! * Int(match.output.2)!
            }
        }

        return result
    }
}
