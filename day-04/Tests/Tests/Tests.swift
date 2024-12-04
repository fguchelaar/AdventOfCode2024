import Testing

@testable import day_04

@Suite
struct TestsTests {
    let input = """
    MMMSXXMASM
    MSAMXMSMSA
    AMXSXMAAMM
    MSAMASMSMX
    XMASAMXAMM
    XXAMMXXAMA
    SMSMSASXSS
    SAXAMASAAA
    MAMMMXMMMM
    MXMXAXMASX
    """

    @Test("Puzzle part 1")
    func part1() {
        let puzzle = Puzzle(
            input: input)
        #expect(puzzle.part1() == 18)
    }

    @Test("Puzzle part 2")
    func part2() {
        let puzzle = Puzzle(
            input: input)
        #expect(puzzle.part2() == 9)
    }
}
