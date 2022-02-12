//
//  Assembunny.swift
//  AOC2016
//
//  Created by Jaydeep Joshi on 29/01/22.
//

import Foundation

class Assembunny {
    private var program: [String]
    private let debug: Bool
    var clockSignal: String
    var pc = 0
    var registers: [Substring: Int] = ["a": 0, "b": 0, "c": 0, "d": 0]

    init(program: [String], debug: Bool = false) {
        self.program = program
        self.debug = debug
        self.clockSignal = ""
    }

    func run() {
        while pc < program.count {
            let line = program[pc]
            if debug {
                print("\(pc) \(line)")
            }
            let split = line.split(separator: " ")
            switch split[0] {
            case "cpy":
                if let _ = registers[split[2]] {
                    registers[split[2]] = Int(split[1]) ?? registers[split[1]]
                }
            case "inc":
                if let _ = registers[split[1]] {
                    registers[split[1]] = registers[split[1]]! + 1
                }
            case "dec":
                if let _ = registers[split[1]] {
                    registers[split[1]] = registers[split[1]]! - 1
                }
            case "jnz":
                let value = Int(split[1]) ?? registers[split[1]]!
                let offset = Int(split[2]) ?? registers[split[2]]!
                if value != 0 {
                    pc += (offset - 1)
                }
            case "tgl":
                let value = Int(split[1]) ?? registers[split[1]]!
                let targetIndex = pc+value
                if targetIndex < program.count {
                    var target = program[pc+value]
                    let targetSplit = target.split(separator: " ")
                    if target.starts(with: "inc") {
                        target.replaceFirst(3, with: "dec")
                    } else if targetSplit.count == 2 {
                        target.replaceFirst(3, with: "inc")
                    } else if target.starts(with: "jnz") {
                        target.replaceFirst(3, with: "cpy")
                    } else {
                        target.replaceFirst(3, with: "jnz")
                    }
                    program[targetIndex] = target
                }
            case "out":
                let value = Int(split[1]) ?? registers[split[1]]!
                clockSignal += "\(value)"
                if clockSignal.count == 100 {
                    return
                }
            default:
                fatalError("Invalid instruction - \(line)")
            }
            pc += 1
        }
    }
}
