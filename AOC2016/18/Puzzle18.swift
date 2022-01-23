//
//  Puzzle18.swift
//  AOC2016
//
//  Created by Jaydeep Joshi on 02/09/21.
//

struct Puzzle18: Puzzle {
    private let input = Array(InputFileReader.read("Input18")[0])
    private let testInput = Array(".^^.^.^^^^")

    func part1() {
        print(safeTiles(start: input, rows: 40))
    }

    func part2() {
        print(safeTiles(start: input, rows: 400000))
    }

    private func safeTiles(start: [Character], rows: Int) -> Int {
        var current = start
        var safeCount = current.filter { $0 == "." }.count
        for _ in 1..<rows {
            current = next(current)
            safeCount += current.filter { $0 == "." }.count
        }
        return safeCount
    }

    private func next(_ current: [Character]) -> [Character] {
        let padded = ["."] + current + ["."]
        var next = [Character]()
        for window in padded.windows(ofCount: 3) {
            let fst = window.first!
            let mid = window[window.index(after: window.startIndex)]
            let lst = window.last!
            if (fst == "^" && mid == "^" && lst == ".") ||
                (fst == "." && mid == "^" && lst == "^") ||
                (fst == "^" && mid == "." && lst == ".") ||
                (fst == "." && mid == "." && lst == "^") {
                next.append("^")
            } else {
                next.append(".")
            }
        }
        return next
    }
}
