//
//  Puzzle25.swift
//  AOC2016
//
//  Created by Jaydeep Joshi on 02/09/21.
//

struct Puzzle25: Puzzle {
    private let program = InputFileReader.read("Input25")

    func part1() {
        let expectedSignal = String(repeating: "01", count: 50)
        for i in (1...) {
            let bunny = Assembunny(program: program)
            bunny.registers["a"] = i
            bunny.run()
            if bunny.clockSignal == expectedSignal {
                print(i)
            }
        }
    }

    func part2() {
        // Nothing to do!
    }
}
