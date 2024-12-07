import AdventKit
import Foundation

class Puzzle: Solvable {
    let rules: [(first: Int, second: Int)]
    let updates: [[Int]]

    required init(input: String) {
        guard #available(macOS 13.0, *) else {
            fatalError()
        }
        let parts = input.split(separator: "\n\n")
        rules = parts[0].trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
            .map { $0.split(separator: "|") }
            .map { (Int($0[0])!, Int($0[1])!) }

        updates = parts[1].trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
            .map { $0.split(separator: ",").compactMap { el in Int(el)! } }
    }

    func isValid(_ rules: [(first: Int, second: Int)], _ update: [Int]) -> Bool {
        guard update.count > 1 else { return true }

        for page in update.enumerated() {
            // find all rules with page as first
            let ruleSet = rules.filter { $0.first == page.element }
            for rule in ruleSet {
                if let secondPageOffset = update.firstIndex(of: rule.second),
                   secondPageOffset < page.offset
                {
                    return false
                }
            }
        }
        return true
    }

    func part1() -> Int {
        updates
            .filter { isValid(self.rules, $0) }
            .map { $0[$0.count / 2] }
            .reduce(0, +)
    }

    func part2() -> Int {
        var invalidUpdates = updates
            .filter { !isValid(self.rules, $0) }

        while !invalidUpdates.allSatisfy({ isValid(self.rules, $0) }) {
            outer: for update in invalidUpdates.enumerated() {
                for page in update.element.enumerated() {
                    // find all rules with page as first
                    let ruleSet = rules.filter { $0.first == page.element }
                    for rule in ruleSet {
                        if let secondPageOffset = update.element.firstIndex(of: rule.second),
                           secondPageOffset < page.offset
                        {
                            invalidUpdates[update.offset].swapAt(page.offset, secondPageOffset)
                            continue outer
                        }
                    }
                }
            }
        }

        return invalidUpdates
            .map { $0[$0.count / 2] }
            .reduce(0, +)
    }
}
