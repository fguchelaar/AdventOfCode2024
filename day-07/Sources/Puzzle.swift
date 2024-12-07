import AdventKit
import Foundation

class Puzzle: Solvable {
    var input: String
    required init(input: String) {
        self.input = input
    }

    // Function to calculate if a target can be achieved with given numbers and operators
    func canProduceTarget(_ numbers: [Int], _ target: Int) -> Bool {
        let operatorCount = numbers.count - 1
        let maxCombinations = Int(pow(2.0, Double(operatorCount))) // 2^operatorCount for all combinations of + and *

        for combination in 0..<maxCombinations {
            var result = numbers[0]

            for i in 0..<operatorCount {
                let isAddition = (combination & (1 << i)) == 0
                if isAddition {
                    result += numbers[i + 1]
                } else {
                    result *= numbers[i + 1]
                }
                // Early exit if result exceeds the target
                if result > target {
                    break
                }
            }

            if result == target {
                return true
            }
        }

        return false
    }

    func part1() -> Int {
        let lines = input.split(separator: "\n")
        var total = 0

        for line in lines {
            let parts = line.split(separator: ":").map { $0.trimmingCharacters(in: .whitespaces) }
            let target = Int(parts[0])!
            let numbers = parts[1].split(separator: " ").compactMap { Int($0) }

            if canProduceTarget(numbers, target) {
                total += target
            }
        }

        return total
    }

    // Function to calculate if a target can be achieved with given numbers and operators
    func canProduceTargetWithConcatenation(_ numbers: [Int], _ target: Int) -> Bool {
        let operatorCount = numbers.count - 1
        let maxCombinations = Int(pow(3.0, Double(operatorCount))) // 3^operatorCount for +, *, and ||

        for combination in 0..<maxCombinations {
            var result = numbers[0]
            var currentCombination = combination

            for i in 0..<operatorCount {
                let operatorType = currentCombination % 3
                currentCombination /= 3

                switch operatorType {
                case 0: // Addition
                    result += numbers[i + 1]
                case 1: // Multiplication
                    result *= numbers[i + 1]
                case 2: // Concatenation
                    let concatenatedValue = Int("\(result)\(numbers[i + 1])")!
                    result = concatenatedValue
                default:
                    break
                }

                // Early exit if result exceeds the target
                if result > target {
                    break
                }
            }

            if result == target {
                return true
            }
        }

        return false
    }

    func part2() -> Int {
        let lines = input.split(separator: "\n")
        var total = 0

        for line in lines {
            let parts = line.split(separator: ":").map { $0.trimmingCharacters(in: .whitespaces) }
            let target = Int(parts[0])!
            let numbers = parts[1].split(separator: " ").compactMap { Int($0) }

            if canProduceTargetWithConcatenation(numbers, target) {
                total += target
            }
        }

        return total
    }
}
