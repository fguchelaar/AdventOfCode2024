public protocol Solvable<P1, P2> {
    associatedtype P1
    associatedtype P2

    init(input: String)
    func part1() -> P1
    func part2() -> P2
}
