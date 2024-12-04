import AdventKit
import Foundation

class Puzzle: Solvable {
    let grid: [[Character]]

    required init(input: String) {
        grid = input.components(separatedBy: .newlines).map { Array($0) }
    }

    func part1() -> Int {
        var count = 0

        let directions: [(r1: Int, r2: Int, r3: Int, c1: Int, c2: Int, c3: Int)] = [
            (-1, -2, -3, 0, 0, 0),
            (-1, -2, -3, 1, 2, 3),
            (0, 0, 0, 1, 2, 3),
            (1, 2, 3, 1, 2, 3),
            (1, 2, 3, 0, 0, 0),
            (1, 2, 3, -1, -2, -3),
            (0, 0, 0, -1, -2, -3),
            (-1, -2, -3, -1, -2, -3),
        ]

        for row in 0..<grid.count {
            for col in 0..<grid[row].count {
                if grid[row][col] == "X" {
                    count += directions.count {
                        grid[safe: row + $0.r1]?[safe: col + $0.c1] == "M"
                            && grid[safe: row + $0.r2]?[safe: col + $0.c2] == "A"
                            && grid[safe: row + $0.r3]?[safe: col + $0.c3] == "S"
                    }
                }
            }
        }
        return count
    }

    func part2() -> Int {
        var count = 0
        for row in 0..<grid.count {
            for col in 0..<grid[row].count {
                if grid[row][col] == "A" {
                    let mas1 =
                        (grid[safe: row - 1]?[safe: col - 1] == "M"
                            && grid[safe: row + 1]?[safe: col + 1] == "S")
                        || (grid[safe: row - 1]?[safe: col - 1] == "S"
                            && grid[safe: row + 1]?[safe: col + 1] == "M")

                    let mas2 =
                        (grid[safe: row - 1]?[safe: col + 1] == "M"
                            && grid[safe: row + 1]?[safe: col - 1] == "S")
                        || (grid[safe: row - 1]?[safe: col + 1] == "S"
                            && grid[safe: row + 1]?[safe: col - 1] == "M")

                    if mas1 && mas2 {
                        count += 1
                    }
                }
            }
        }
        return count
    }
}
