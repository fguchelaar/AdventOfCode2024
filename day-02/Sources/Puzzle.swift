import AdventKit
import Foundation

class Puzzle: Solvable {
    let reports: [[Int]]

    required init(input: String) {
        reports = input
            .components(separatedBy: .newlines)
            .map { $0.components(separatedBy: .whitespaces).compactMap(Int.init) }
    }

    func isSafe(_ report: [Int]) -> Bool {
        report.allHaveMaxDifference(from: 1, to: 3)
            || report.allHaveMaxDifference(from: -3, to: -1)
    }

    func part1() -> Int {
        reports.filter(isSafe(_:)).count
    }

    func part2() -> Int {
        reports
            .filter { $0.lazyRemovingOneElement().contains(where: isSafe(_:)) }
            .count
    }
}
