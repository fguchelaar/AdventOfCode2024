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
