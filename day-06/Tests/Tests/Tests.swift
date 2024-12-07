import Testing

@testable import day_06

@Suite
struct TestsTests {
    let input = """
    ....#.....
    .........#
    ..........
    ..#.......
    .......#..
    ..........
    .#..^.....
    ........#.
    #.........
    ......#...
    """
    
    @Test("Puzzle part 1")
    func part1() {
        let puzzle = Puzzle(input: input)
        #expect(puzzle.part1() == 41)
    }
    
    @Test("Puzzle part 2")
    func part2() {
        let puzzle = Puzzle(input: input)
        #expect(puzzle.part2() == 6)
    }
    
    @Test("Puzzle part 2")
    func part2_1() {
        let puzzle = Puzzle(input: """
        .##.#
        ...O.
        .....
        #.^..
        ..#..
        """)
        #expect(puzzle.part2() == 1)
    }
    
    @Test("Puzzle part 2")
    func part2_2() {
        let puzzle = Puzzle(input: """
        ..O.#
        ...#.
        .#^..
        ..#..
        """)
        #expect(puzzle.part2() == 1)
    }
}
