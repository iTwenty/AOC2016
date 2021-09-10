//
//  Puzzle09.swift
//  AOC2016
//
//  Created by Jaydeep Joshi on 02/09/21.
//

struct Puzzle09: Puzzle {
    private let input = InputFileReader.read("Input09")[0]

    func part1() {
        print(length(input))
    }

    func part2() {
        print(length(input, recurse: true))
    }

    func length(_ str: String, recurse: Bool = false) -> Int {
        let chars = Array(str)
        var count = 0
        var index = 0
        while index < chars.count {
            let char = chars[index]
            if char == "(" {
                let endIndex = chars[(index+1)...].firstIndex(of: ")")!
                let marker = String(chars[(index+1)..<endIndex])
                let split = marker.split(separator: "x")
                let len = Int(split[0])!
                let rpt = Int(split[1])!
                if recurse {
                    count += (length(String(chars[(endIndex+1)...(endIndex+len)])) * rpt)
                } else {
                    count += (len * rpt)
                }
                index = endIndex + 1 + len
            } else {
                count += 1
                index += 1
            }
        }
        return count
    }
}
