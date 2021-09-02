//
//  Puzzle01.swift
//  AOC2016
//
//  Created by Jaydeep Joshi on 02/09/21.
//

import ComplexModule

fileprivate typealias Instruction = (turn: Character, steps: Int)

struct Puzzle01: Puzzle {
    private let instructions: [Instruction]

    init() {
        instructions = InputFileReader.read("Input01")[0].components(separatedBy: ", ").map { str in
            let turn = str.first!
            let steps = Int(str.dropFirst())!
            return (turn, steps)
        }
    }

    func part1() {
        var direction = Complex(0, 1)
        var position = Complex(0, 0)
        instructions.forEach { instruction in
            direction *= (instruction.turn == "L") ? Complex(0, 1) : Complex(0, -1)
            let steps = instruction.steps
            position += (Complex(0, Double(steps)) * direction)
        }
        print(position.real.magnitude + position.imaginary.magnitude)
    }

    func part2() {
        var direction = Complex(0, 1)
        var position = Complex(0, 0)
        var visited: Set<Complex<Double>> = [position]
        for instruction in instructions {
            direction *= (instruction.turn == "L") ? Complex(0, 1) : Complex(0, -1)
            let steps = instruction.steps
            for _ in 1...steps {
                position += direction
                if visited.contains(position) {
                    print(position.real.magnitude + position.imaginary.magnitude)
                    return
                } else {
                    visited.insert(position)
                }
            }
        }
    }
}
