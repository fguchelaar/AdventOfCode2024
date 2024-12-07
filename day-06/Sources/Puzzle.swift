import AdventKit
import Foundation

enum Direction {
    case up
    case right
    case down
    case left

    var vector: Point {
        switch self {
        case .up:
            return .init(x: 0, y: -1)
        case .right:
            return .init(x: 1, y: 0)
        case .down:
            return .init(x: 0, y: 1)
        case .left:
            return .init(x: -1, y: 0)
        }
    }

    var right: Direction {
        switch self {
        case .up:
            return .right
        case .right:
            return .down
        case .down:
            return .left
        case .left:
            return .up
        }
    }
}

class Player {
    private(set) var location: Point
    private(set) var direction: Direction

    init(location: Point, direction: Direction = .up) {
        self.location = location
        self.direction = direction
    }

    func rotateRight() {
        direction = direction.right
    }

    func peek() -> Point {
        location + direction.vector
    }

    func peekRight() -> Point {
        location + direction.right.vector
    }

    func move() {
        location = peek()
    }
}

class Puzzle: Solvable {
    let obstructions: [Point]
    let start: Point

    required init(input: String) {
        var obstructions: [Point] = []
        var start: Point!
        for row in input.components(separatedBy: .newlines).enumerated() {
            for col in row.element.enumerated() {
                if col.element == "#" {
                    obstructions.append(Point(x: col.offset, y: row.offset))
                } else if col.element == "^" {
                    start = Point(x: col.offset, y: row.offset)
                }
            }
        }
        self.start = start
        self.obstructions = obstructions
    }

    func part1() -> Int {
        let upperBoundX = obstructions.max(by: { $0.x < $1.x })?.x ?? 0
        let upperBoundY = obstructions.max(by: { $0.y < $1.y })?.y ?? 0

        var visited: Set<Point> = []
        let player = Player(location: start)
        visited.insert(player.location)

        while player.location.x > 0
            && player.location.y > 0
            && player.location.x < upperBoundX
            && player.location.y < upperBoundY
        {
            if obstructions.contains(player.peek()) {
                player.rotateRight()
            } else {
                player.move()
                visited.insert(player.location)
            }
        }

        return visited.count
    }

    struct PointDirection: Hashable {
        let point: Point
        let direction: Direction
    }

    func part2() -> Int {
        let upperBoundX = obstructions.max(by: { $0.x < $1.x })?.x ?? 0
        let upperBoundY = obstructions.max(by: { $0.y < $1.y })?.y ?? 0

        var visited: Set<PointDirection> = []
        var loopCount = 0
        let player = Player(location: start)

        visited.insert(PointDirection(point: player.location, direction: player.direction))

        while player.location.x > 0
            && player.location.y > 0
            && player.location.x < upperBoundX
            && player.location.y < upperBoundY
        {
            let dummy = Player(location: player.location, direction: player.direction.right)

            let extra = player.peek()
            if !visited.contains(where: { $0.point == extra }) {
                var dummyLoop: Set<PointDirection> = []
                while dummy.location.x > 0
                    && dummy.location.y > 0
                    && dummy.location.x < upperBoundX
                    && dummy.location.y < upperBoundY
                {
                    let pd = PointDirection(point: dummy.location, direction: dummy.direction)

                    if visited.contains(pd)
                        || dummyLoop.contains(pd)
                    {
                        loopCount += 1
                        break
                    }

                    dummyLoop.insert(pd)

                    if dummy.peek() == extra || obstructions.contains(dummy.peek()) {
                        dummy.rotateRight()
                    } else {
                        dummy.move()
                    }
                }
            }

            if obstructions.contains(player.peek()) {
                player.rotateRight()
            } else {
                player.move()
            }
            visited.insert(PointDirection(point: player.location, direction: player.direction))
        }

        return loopCount
    }
}
