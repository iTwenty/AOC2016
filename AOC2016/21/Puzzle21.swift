//
//  Puzzle21.swift
//  AOC2016
//
//  Created by Jaydeep Joshi on 02/09/21.
//

import Collections

struct Puzzle21: Puzzle {
    private let password = "abcdefgh"
    private let input = InputFileReader.read("Input21")

    func part1() {
        print(String(scramble(Array(password))))
    }

    func part2() {
        let permutations = password.permutations()
        let first = permutations.first { pw in
            scramble(pw) == Array("fbgdceah")
        }!
        print(String(first))
    }

    private func scramble(_ password: [Character]) -> [Character] {
        var pw = Array(password)
        input.forEach { line in
            let split = line.components(separatedBy: " ")
            if line.starts(with: "swap position") {
                swapPosition(&pw, x: Int(split[2])!, y: Int(split[5])!)
            } else if line.starts(with: "swap letter") {
                swapLetter(&pw, x: Character(split[2]), y: Character(split[5]))
            } else if line.starts(with: "rotate left") {
                rotateLeft(&pw, x: Int(split[2])!)
            } else if line.starts(with: "rotate right") {
                rotateRight(&pw, x: Int(split[2])!)
            } else if line.starts(with: "rotate based") {
                rotateLetter(&pw, x: Character(split[6]))
            } else if line.starts(with: "reverse") {
                reversePosition(&pw, x: Int(split[2])!, y: Int(split[4])!)
            } else if line.starts(with: "move") {
                movePosition(&pw, x: Int(split[2])!, y: Int(split[5])!)
            } else {
                fatalError("Invalid operation - \(line)")
            }
        }
        return pw
    }

    private func swapPosition(_ pw: inout [Character], x: Int, y: Int) {
        pw.swapAt(x, y)
    }

    private func swapLetter(_ pw: inout [Character], x: Character, y: Character) {
        pw.swapAt(pw.firstIndex(of: x)!, pw.firstIndex(of: y)!)
    }

    private func rotateLeft(_ pw: inout [Character], x: Int) {
        pw.rotate(toStartAt: x)
    }

    private func rotateRight(_ pw: inout [Character], x: Int) {
        pw.rotate(toStartAt: pw.endIndex - x)
    }

    private func rotateLetter(_ pw: inout [Character], x: Character) {
        var index = pw.firstIndex(of: x)!
        if index >= 4 {
            index += 1
        }
        rotateRight(&pw, x: (index+1) % pw.count)
    }

    private func reversePosition(_ pw: inout [Character], x: Int, y: Int) {
        pw.reverse(subrange: x..<y+1)
    }

    private func movePosition(_ pw: inout [Character], x: Int, y: Int) {
        pw.insert(pw.remove(at: x), at: y)
    }
}
