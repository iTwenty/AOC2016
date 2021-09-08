//
//  Puzzle08.swift
//  AOC2016
//
//  Created by Jaydeep Joshi on 02/09/21.
//

fileprivate class Screen: CustomStringConvertible {
    let rows = 6
    let cols = 50
    private var pixels: [[Character]]

    init() {
        pixels = Array(repeating: Array(repeating: ".", count: cols), count: rows)
    }

    var description: String {
        pixels.map { String($0) }.reduce("") { acc, row in
            acc + "\n" + row
        }
    }

    func apply(_ op: Operation) {
        switch op {
        case .rect(let rows, let cols):
            for col in (0..<cols) {
                for row in (0..<rows) {
                    pixels[row][col] = "#"
                }
            }
        case .rrow(let row, let amount):
            var newRow = [Character]()
            for col in 0..<cols {
                var newcol = col - amount
                if newcol < 0 {
                    newcol = cols + newcol
                }
                newRow.append(pixels[row][newcol])
            }
            pixels[row] = newRow
        case .rcol(let col, let amount):
            var newCol = [Character]()
            for row in 0..<rows {
                var newrow = row - amount
                if newrow < 0 {
                    newrow = rows + newrow
                }
                newCol.append(pixels[newrow][col])
            }
            for row in 0..<rows {
                pixels[row][col] = newCol[row]
            }
        }
    }

    var onCount: Int {
        pixels.flatMap { row in
            row.filter { $0 == "#" }
        }.count
    }
}

fileprivate enum Operation {
    case rect(_ rows: Int, _ cols: Int)
    case rrow(_ row: Int, amount: Int)
    case rcol(_ col: Int, amount: Int)

    static func from(_ string: String) -> Operation {
        var split = string.split(separator: " ")
        if split[0] == "rect" {
            split = split[1].split(separator: "x")
            let rows = Int(split[1])!
            let cols = Int(split[0])!
            return .rect(rows, cols)
        } else {
            let dir = split[1]
            let amount = Int(split[4])!
            let pos = Int(split[2].split(separator: "=")[1])!
            return dir == "row" ? .rrow(pos, amount: amount) : .rcol(pos, amount: amount)
        }
    }
}

struct Puzzle08: Puzzle {
    private let ops = InputFileReader.read("Input08").map(Operation.from)
    private var screen = Screen()

    func part1() {
        ops.forEach { screen.apply($0) }
        print(screen.onCount) // p1
        print(screen) // p2
    }

    func part2() { }
}
