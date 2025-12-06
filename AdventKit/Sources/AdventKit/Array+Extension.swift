public extension Array where Element == Int {
    func allHaveMaxDifference(from min: Int, to max: Int) -> Bool {
        zip(self, dropFirst()).allSatisfy { $1 - $0 >= min && $1 - $0 <= max }
    }

    func lazyRemovingOneElement() -> LazyMapSequence<Indices, [Element]> {
        indices.lazy.map { index in
            var copy = self
            copy.remove(at: index)
            return copy
        }
    }
}

public extension Array {
    func combinations(of count: Int) -> [[Element]] {
        guard count > 0 else { return [[]] }
        guard let first = first else { return [] }

        let subarray = Array(dropFirst())
        let withFirst = subarray.combinations(of: count - 1).map { [first] + $0 }
        let withoutFirst = subarray.combinations(of: count)

        return withFirst + withoutFirst
    }
}
