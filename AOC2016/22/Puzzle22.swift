//
//  Puzzle22.swift
//  AOC2016
//
//  Created by Jaydeep Joshi on 02/09/21.
//

fileprivate struct Node: Hashable {
    let x, y, size, used, avail, pc: Int
}

struct Puzzle22: Puzzle {
    private let nodes: [Node]

    init() {
        nodes = InputFileReader.read("Input22").dropFirst(2).map { line in
            let split = line.components(separatedBy: " ").filter { !$0.isEmpty }
            let path = split[0]
            let pathSplit = path.components(separatedBy: "-")
            let x = Int(pathSplit[1].dropFirst())!
            let y = Int(pathSplit[2].dropFirst())!
            let size = Int(split[1].dropLast())!
            let used = Int(split[2].dropLast())!
            let avail = Int(split[3].dropLast())!
            let pc = Int(split[4].dropLast())!
            return Node(x: x, y: y, size: size, used: used, avail: avail, pc: pc)
        }
    }

    func part1() {
        var viablePairs = 0
        for i in nodes {
            for j in nodes {
                if i.x == j.x && i.y == j.y {
                    continue
                }
                if i.used != 0, i.used <= j.avail {
                    viablePairs += 1
                }
            }
        }
        print(viablePairs)
    }

    func part2() {
        let grid = nodes.sorted { lhs, rhs in
            if lhs.y == rhs.y {
                return lhs.x <= rhs.x
            }
            return lhs.y < rhs.y
        }.chunked { fst, snd in
            fst.y == snd.y
        }.map { row -> String in
            let charArray = row.map { node -> Character in
                if node.x == row.count - 1, node.y == 0 {
                    return "G"
                } else if node.size >= 500 {
                    return "#"
                } else if node.used == 0 {
                    return "_"
                }
                return "."
            }
            return String(charArray)
        }

        // Prints out the whole grid. Just manually count the number of steps
        // needed to move G to (0, 0) using by swapping _ with neighbours in
        // each step. Not sure how to solve this programatically 🤷‍♂️
        grid.forEach { row in
            print(row)
        }
    }
}
