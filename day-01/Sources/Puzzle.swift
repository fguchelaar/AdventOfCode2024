import AdventKit
import Foundation

class Puzzle: Solvable {
    let locationsA: [Int]
    let locationsB: [Int]

    required init(input: String) {
        (locationsA, locationsB) = input
            .components(separatedBy: .newlines)
            .map { $0.components(separatedBy: .whitespaces).compactMap(Int.init) }
            .reduce(into: (a: [Int](), b: [Int]())) { result, tuple in
                result.a.append(tuple[0]!)
                result.b.append(tuple[1]!)
            }
    }

    func part1() -> Int {
        zip(locationsA.sorted(), locationsB.sorted())
            .map { abs($0.0 - $0.1) }
            .reduce(0, +)
    }

    func part2() -> Int {
        locationsA.map { a in
            a * locationsB.count(where: { a == $0 })
        }.reduce(0, +)
    }
}
