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

        // Get all nodes for every group
        let antinodes = Set(groups.flatMap { _, points in
            let nodes = points.combinations(of: 2)
                .flatMap { comb in
                    [comb[0] - (comb[1] - comb[0]),
                     comb[1] - (comb[0] - comb[1])]
                }
                .filter { antinode in
                    antinode.x >= minPoint.x &&
                        antinode.x <= maxPoint.x &&
                        antinode.y >= minPoint.y &&
                        antinode.y <= maxPoint.y
                }
            return nodes
        })

        return antinodes.count
    }

    func part2() -> Int {
        // Group the grid by character
        let groups: [Character: [Point]] = Dictionary(grouping: grid.keys, by: { grid[$0]! })

        // Get all nodes for every group
        let antinodes = Set(groups.flatMap { _, points in
            let nodes = points.combinations(of: 2)
                .flatMap { comb in
                    var anodes = [Point]()

                    let delta1 = comb[1] - comb[0]

                    var start = comb[0]
                    while (start - delta1).between(minPoint, maxPoint) {
                        start = start - delta1
                        anodes.append(start)
                    }

                    let delta2 = comb[0] - comb[1]
                    var end = comb[1]
                    while (end - delta2).between(minPoint, maxPoint) {
                        end = end - delta2
                        anodes.append(end)
                    }
                    return anodes
                }
            // we also need to include the antennas
            return nodes + points
        })

        return antinodes.count
    }
}
