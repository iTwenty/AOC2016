//
//  Puzzle24.swift
//  AOC2016
//
//  Created by Jaydeep Joshi on 02/09/21.
//

import Collections
import Algorithms

fileprivate struct Point: Hashable {
    let x, y: Int

    func openNeighbours(_ map: [Point: Character]) -> Set<Point> {
        let neighbours: Set<Point > = [Point(x: x, y: y - 1),
                                       Point(x: x + 1, y: y),
                                       Point(x: x, y: y + 1),
                                       Point(x: x - 1, y: y)]
        return neighbours.filter { map.keys.contains($0) }
    }
}

fileprivate struct Cost: Hashable {
    let p: Point
    let c: Int
}

class Puzzle24: Puzzle {
    private var map = [Point: Character]()
    private var numbers = [Character: Point]()
    private var minDistances = [Set<Character>: Int]()

    init() {
        //let lines = InputFileReader.read("Input24-test")
        let lines = InputFileReader.read("Input24")
        lines.enumerated().forEach { (y, line) in
            line.enumerated().forEach { (x, char) in
                if char != "#" {
                    let point = Point(x: x, y: y)
                    map[point] = char
                    if char != "." {
                        numbers[char] = point
                    }
                }
            }
        }
        // Min distances between each pair of numbers is required for both parts
        // So, compute them in init and save as property
        computeMinDistancesUsingBfs()
    }

    func part1() {
        print(travelingSalesman())
    }

    func part2() {
        print(travelingSalesman(p2: true))
    }

    private func computeMinDistancesUsingBfs() {
        numbers.forEach { (number, point) in
            let minDistancesFromNumber = minDistancesToAllNumbers(start: number)
            minDistancesFromNumber.forEach { (otherNumber, distance) in
                minDistances[[number, otherNumber]] = distance
            }
        }
    }

    private func travelingSalesman(p2: Bool = false) -> Int {
        var curMin = Int.max
        numbers.keys.permutations().forEach {
            var keys = $0
            if p2 {
                keys.append("0")
            }
            // Must start at 0. We can remove 0, permute rest of keys and add 0
            // back at first index to save some time, but this works fast enough
            // as is.
            if keys.first == "0" {
                var curDistance = 0
                for pair in keys.adjacentPairs() {
                    curDistance += (minDistances[[pair.0, pair.1]]!)
                }
                if curDistance < curMin {
                    curMin = curDistance
                }
            }
        }
        return curMin
    }

    private func minDistancesToAllNumbers(start: Character) -> [Character: Int] {
        let p = numbers[start]!
        let startCost = Cost(p: p, c: 0)
        var costs = [Character: Int]()
        var queue = Deque([startCost])
        var visited = Set<Point>([p])
        while let current = queue.popFirst() {
            if map[current.p] != ".", current.c != 0 {
                costs[map[current.p]!] = current.c
            }
            let openNeighbours = current.p.openNeighbours(map)
            let unvisited = openNeighbours.filter { !visited.contains($0) }
            for uv in unvisited {
                visited.insert(uv)
                queue.append(Cost(p: uv, c: current.c + 1))
            }
        }
        return costs
    }
    
}
