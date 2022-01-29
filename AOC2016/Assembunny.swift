//
//  Assembunny.swift
//  AOC2016
//
//  Created by Jaydeep Joshi on 29/01/22.
//

import Foundation

class Assembunny {
    private let program: [String]
    var pc = 0
    var registers: [Substring: Int] = ["a": 0, "b": 0, "c": 0, "d": 0]

    init(program: [String]) {
        self.program = program
    }

    func run() {
        while pc < program.count {
            let line = program[pc]
            let split = line.split(separator: " ")
            switch split[0] {
            case "cpy":
                registers[split[2]] = Int(split[1]) ?? registers[split[1]]
            case "inc":
                registers[split[1]] = registers[split[1]]! + 1
            case "dec":
                registers[split[1]] = registers[split[1]]! - 1
            case "jnz":
                let value = Int(split[1]) ?? registers[split[1]]!
                if value != 0 {
                    pc += (Int(split[2])! - 1)
                }
            default:
                fatalError("Invalid instruction - \(line)")
            }
            pc += 1
        }
    }
}
