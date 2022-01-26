//
//  Puzzle20.swift
//  AOC2016
//
//  Created by Jaydeep Joshi on 02/09/21.
//

import Foundation
import SE0270_RangeSet

struct Puzzle20: Puzzle {
    private var blacklist = RangeSet<Int>()

    init() {
        InputFileReader.read("Input20").forEach({ line in
            let split = line.split(separator: "-")
            blacklist.insert(contentsOf: Int(split[0])!..<Int(split[1])!+1)
        })
    }

    func part1() {
        var all = RangeSet(0..<4294967296)
        all.subtract(blacklist)
        // p1
        print(all.ranges.first?.lowerBound ?? -1)
        // p2
        print(all.ranges.map(\.count).reduce(0, +))
    }

    func part2() { }
}
