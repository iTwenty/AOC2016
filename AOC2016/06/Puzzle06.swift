//
//  Puzzle06.swift
//  AOC2016
//
//  Created by Jaydeep Joshi on 02/09/21.
//

struct Puzzle06: Puzzle {
    private let input = InputFileReader.read("Input06").map(Array.init)

    func part1() {
        print(decode(p1: true))
    }

    func part2() {
        print(decode(p1: false))
    }

    private func decode(p1: Bool) -> String {
        var msg = ""
        for i in 0..<input[0].count {
            var charCounts = [Character: Int]()
            for j in 0..<input.count {
                let char = input[j][i]
                let charCount = charCounts[char, default: 0]
                charCounts[char] = charCount + 1
            }
            if p1 {
                msg.append(charCounts.max { $0.value < $1.value }!.key)
            } else {
                msg.append(charCounts.max { $0.value > $1.value }!.key)
            }
        }
        return msg
    }
}
