//
//  Puzzle23.swift
//  AOC2016
//
//  Created by Jaydeep Joshi on 02/09/21.
//

struct Puzzle23: Puzzle {
    private let program = InputFileReader.read("Input23")

    func part1() {
        let bunny = Assembunny(program: program)
        bunny.registers["a"] = 7
        bunny.run()
        print(bunny.registers["a"]!)
    }

    // Doesn't produce answer in reasonable time
    // Optimization is to replace inc loop with
    // new add instruction and add loop with new
    // mul instruction in assembunny. Not implemented
    func part2() {
        let bunny = Assembunny(program: program, debug: true)
        bunny.registers["a"] = 12
        bunny.run()
        print(bunny.registers["a"]!)
    }
}
