import Testing

@testable import day_03

@Suite
struct TestsTests {
    @Test("Puzzle part 1")
    func part1() {
        let puzzle = Puzzle(input: "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))")
        #expect(puzzle.part1() == 161)
    }

    @Test("Puzzle part 2")
    func part2() {
        let puzzle = Puzzle(input: "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))")
        #expect(puzzle.part2() == 48)
    }
}
