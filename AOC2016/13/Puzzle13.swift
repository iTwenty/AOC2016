//
//  Puzzle13.swift
//  AOC2016
//
//  Created by Jaydeep Joshi on 02/09/21.
//

import Collections

fileprivate struct Point: Hashable {
    let x, y: Int

    func isOpen() -> Bool {
        let tmp = x * x + 3 * x + 2 * x * y + y + y * y + 1364
        let bin = String(tmp, radix: 2)
        let onesCount = bin.filter { $0 == "1" }.count
        return onesCount % 2 == 0
    }

    func openNeighbours() -> Set<Point> {
        let neighbours: Set<Point > = [Point(x: x, y: y - 1),
                                       Point(x: x + 1, y: y),
                                       Point(x: x, y: y + 1),
                                       Point(x: x - 1, y: y)]
        return neighbours.filter { p in
            p.x >= 0 && p.y >= 0 && p.isOpen()
        }
    }
}


fileprivate struct Cost: Hashable {
    let point: Point
    let cost: Int
}

struct Puzzle13: Puzzle {

    func part1() {
        let start = Point(x: 1, y: 1)
        let end = Point(x: 31, y: 39)
        print(minSteps(start: start, end: end))
    }

    func part2() {
        let start = Point(x: 1, y: 1)
        print(flood(start: start, steps: 50))
    }

    private func minSteps(start: Point, end: Point) -> Int {
        let startCost = Cost(point: start, cost: 0)
        var queue = Deque([startCost])
        var visited = Set<Point>([start])
        while let current = queue.popFirst() {
            if current.point == end {
                return current.cost
            }
            let openNeighbours = current.point.openNeighbours()
            let unvisited = openNeighbours.filter { !visited.contains($0) }
            for uv in unvisited {
                visited.insert(uv)
                queue.append(Cost(point: uv, cost: current.cost + 1))
            }
        }
        return -1
    }

    private func flood(start: Point, steps: Int) -> Int {
        let startCost = Cost(point: start, cost: 0)
        var queue = Deque([startCost])
        var visited = Set<Point>([start])
        while let current = queue.popFirst() {
            if current.cost >= steps {
                return visited.count
            }
            let openNeighbours = current.point.openNeighbours()
            let unvisited = openNeighbours.filter { !visited.contains($0) }
            for uv in unvisited {
                visited.insert(uv)
                queue.append(Cost(point: uv, cost: current.cost + 1))
            }
        }
        return -1
    }

    // Below methods are not used in solution, but good for reference
    // of how to find BFS shortest path
    private func shortesPath(start: Point, end: Point) -> [Point] {
        if start == end {
            return [start]
        }
        var queue = Deque([start])
        var visited = Set<Point>([start])
        var prevs = [Point: Point]()
        while let current = queue.popFirst() {
            let openNeighbours = current.openNeighbours()
            let unvisited = openNeighbours.filter { !visited.contains($0) }
            for uv in unvisited {
                prevs[uv] = current
                if uv == end {
                    return path(start: start, end: end, prevs: prevs)
                }
                visited.insert(uv)
            }
            queue.append(contentsOf: unvisited)
        }
        return []
    }

    private func path(start: Point, end: Point, prevs: [Point: Point]) -> [Point] {
        var path = [end]
        var current = end
        while let tmp = prevs[current] {
            path.append(tmp)
            if tmp == start {
                return path.reversed()
            }
            current = tmp
        }
        return []
    }
}
