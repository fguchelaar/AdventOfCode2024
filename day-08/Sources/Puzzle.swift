import AdventKit
import Foundation

class Puzzle: Solvable {
    let grid: [Point: Character]
    let minPoint = Point.zero
    let maxPoint: Point

    required init(input: String) {
        var tempGrid = [Point: Character]()
        for (y, line) in input.components(separatedBy: .newlines).enumerated() {
            for (x, char) in line.enumerated() {
                if char == "." { continue }
                tempGrid[Point(x: x, y: y)] = char
            }
        }
        grid = tempGrid

        maxPoint = Point(
            x: input.components(separatedBy: .newlines)[0].count - 1,
            y: input.components(separatedBy: .newlines).count - 1
        )
    }

    func part1() -> Int {
        // Group the grid by character
        let groups: [Character: [Point]] = Dictionary(grouping: grid.keys, by: { grid[$0]! })

        let antinodes = Set(groups.flatMap { _, points in
            let combinations = points.combinations(of: 2)
            let antinodes = combinations.flatMap { comb in
                [comb[0] - (comb[1] - comb[0]),
                 comb[1] - (comb[0] - comb[1])]
            }
            .filter { antinode in
                antinode.x >= minPoint.x &&
                    antinode.x <= maxPoint.x &&
                    antinode.y >= minPoint.y &&
                    antinode.y <= maxPoint.y
            }
            return antinodes
        })

        return antinodes.count
    }

    func part2() -> Int {
        -1
    }
}
