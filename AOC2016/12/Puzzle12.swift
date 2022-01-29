//
//  Puzzle12.swift
//  AOC2016
//
//  Created by Jaydeep Joshi on 02/09/21.
//

struct Puzzle12: Puzzle {

    private let input = InputFileReader.read("Input12")

    func part1() {
        let bunny = Assembunny(program: input)
        bunny.run()
        print(bunny.registers["a"]!)
    }

    func part2() {
        let bunny = Assembunny(program: input)
        bunny.registers["c"] = 1
        bunny.run()
        print(bunny.registers["a"]!)
    }
}
