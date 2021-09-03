//
//  Puzzle02.swift
//  AOC2016
//
//  Created by Jaydeep Joshi on 02/09/21.
//

import Algorithms

struct Puzzle02: Puzzle {
    private let allMoves = InputFileReader.read("Input02")
    private let keypad = "123456789".chunks(ofCount: 3).map(Array.init)
    private let fancyKeypad = ["00100",
                               "02340",
                               "56789",
                               "0ABC0",
                               "00D00"].map(Array.init)

    func part1() {
        var pin = ""
        var index = (1, 1)
        for moves in allMoves {
            index = processMoves(moves, startIndex: index, keypad: keypad)
            pin.append("\(keypad[index.0][index.1])")
        }
        print(pin)
    }

    func part2() {
        var pin = ""
        var index = (1, 1)
        for moves in allMoves {
            index = processMoves(moves, startIndex: index, keypad: fancyKeypad)
            pin.append("\(fancyKeypad[index.0][index.1])")
        }
        print(pin)
    }

    private func processMoves(_ moves: String, startIndex: (Int, Int), keypad: [[Character]]) -> (Int, Int) {
        var currentIndex = startIndex
        for move in moves {
            let newIndex = newIndex(forMove: move, current: currentIndex)
            if keypad.indices.contains(newIndex.1),
               keypad[0].indices.contains(newIndex.0),
               keypad[newIndex.0][newIndex.1] != "0" {
                currentIndex = newIndex
            }
        }
        return currentIndex
    }

    private func newIndex(forMove move: Character, current: (Int, Int)) -> (Int, Int) {
        switch move {
        case "L": return (current.0, current.1 - 1)
        case "R": return (current.0, current.1 + 1)
        case "U": return (current.0 - 1, current.1)
        case "D": return (current.0 + 1, current.1)
        default: fatalError("Invalid move : \(move)")
        }
    }
}
