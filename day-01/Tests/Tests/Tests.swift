import Testing

@testable import day_01

@Suite
struct TestsTests {
    let input = """
    3   4
    4   3
    2   5
    1   3
    3   9
    3   3
    """
    
    @Test("Puzzle part 1")
    func part1() {
        let puzzle = Puzzle(input: input)
        #expect(puzzle.part1() == 11)
    }
    
    @Test("Puzzle part 2")
    func part2() {
        let puzzle = Puzzle(input: input)
        #expect(puzzle.part2() == 31)
    }
}
