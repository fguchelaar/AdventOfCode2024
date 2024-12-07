// The Swift Programming Language
// https://docs.swift.org/swift-book
import AdventKit
import Foundation

let path = Bundle.module.path(forResource: "input", ofType: "txt")!
let input = try! String(contentsOf: URL(fileURLWithPath: path))
let puzzle = Puzzle(input: input.trimmingCharacters(in: .whitespacesAndNewlines))

print("Part 1: \(puzzle.part1())")
print("Part 2: \(puzzle.part2())")
