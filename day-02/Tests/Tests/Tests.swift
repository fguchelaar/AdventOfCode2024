import Testing

@testable import day_02

@Suite
struct TestsTests {
    let input = """
    7 6 4 2 1
    1 2 7 8 9
    9 7 6 2 1
    1 3 2 4 5
    8 6 4 4 1
    1 3 6 7 9
    """

    @Test("Puzzle part 1")
    func part1() {
        let puzzle = Puzzle(input: input)
        #expect(puzzle.part1() == 2)
    }

    @Test("Puzzle part 2")
    func part2() {
        let puzzle = Puzzle(input: input)
        #expect(puzzle.part2() == 4)
    }
}
