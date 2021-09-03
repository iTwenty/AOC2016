//
//  Puzzle03.swift
//  AOC2016
//
//  Created by Jaydeep Joshi on 02/09/21.
//

import Algorithms

struct Puzzle03: Puzzle {
    private let triplets: [[Int]]

    init() {
        triplets = InputFileReader.read("Input03").map { line in
            line.components(separatedBy: " ").compactMap(Int.init)
        }
    }

    func part1() {
        print(triplets.filter(isTriangle).count)
    }

    func part2() {
        var newTriplets = [[Int]]()
        for i in stride(from: 0, to: triplets.count - 2, by: 3) {
            let sub = triplets[i..<(i+3)]
            for j in 0..<3 {
                var newTriplet = [Int]()
                newTriplet.append(sub[sub.startIndex][j])
                newTriplet.append(sub[sub.startIndex+1][j])
                newTriplet.append(sub[sub.startIndex+2][j])
                newTriplets.append(newTriplet)
            }
        }
        print(newTriplets.filter(isTriangle).count)
    }

    private func isTriangle(_ triplet: [Int]) -> Bool {
        guard triplet.count == 3 else {
            return false
        }
        let max = triplet.max()!
        let sum = triplet.reduce(0, +) - max
        return sum > max
    }
}
