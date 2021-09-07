//
//  Puzzle07.swift
//  AOC2016
//
//  Created by Jaydeep Joshi on 02/09/21.
//

import Foundation
import Algorithms

fileprivate struct IP: ExpressibleByStringLiteral {
    let normals, hypers: [String]

    init(stringLiteral value: String) {
        let set = CharacterSet(charactersIn: "[]")
        let split = value.components(separatedBy: set)
        (normals, hypers) = split.enumerated().reduce(into: ([String](), [String]())) { acc, elem in
            if elem.offset % 2 == 0 {
                acc.0.append(elem.element)
            } else {
                acc.1.append(elem.element)
            }
        }
    }
}

struct Puzzle07: Puzzle {
    private let ips = InputFileReader.read("Input07").map(IP.init)

    func part1() {
        print(ips.filter(hasTLS).count)
    }

    func part2() {
        print(ips.filter(hasSSL).count)
    }

    private func hasTLS(_ ip: IP) -> Bool {
        ip.normals.contains { hasAbba($0) } && !ip.hypers.contains { hasAbba($0) }
    }

    private func hasAbba(_ string: String) -> Bool {
        for w in string.windows(ofCount: 4) {
            let asciis = Array(w).map { $0.asciiValue! }
            if asciis[0] == asciis[3],
               asciis[1] == asciis[2],
               asciis[0] != asciis[1] {
                return true
            }
        }
        return false
    }

    private func hasSSL(_ ip: IP) -> Bool {
        let (normalAbas, hyperAbas) = allAbas(ip)
        let normalBabs = normalAbas.map(bab)
        return hyperAbas.contains { hyperAba in
            normalBabs.contains(hyperAba)
        }
    }

    private func allAbas(_ ip: IP) -> ([String], [String]) {
        (abas(ip.normals), abas(ip.hypers))
    }

    private func abas(_ strings: [String]) -> [String] {
        var abas = [String]()
        for string in strings {
            for w in string.windows(ofCount: 3) {
                let asciis = Array(w).map { $0.asciiValue! }
                if asciis[0] == asciis[2], asciis[1] != asciis[0] {
                    abas.append(String(w))
                }
            }
        }
        return abas
    }

    private func bab(_ aba: String) -> String {
        let first = aba.first!
        let middle = aba[aba.index(after: aba.startIndex)]
        return "\(middle)\(first)\(middle)"
    }
}
