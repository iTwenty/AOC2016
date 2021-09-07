//
//  Puzzle05.swift
//  AOC2016
//
//  Created by Jaydeep Joshi on 02/09/21.
//

import CryptoKit

struct Puzzle05: Puzzle {
    private static let test = false
    private let id = test ? "abc" : "cxdnnyjw"

    func part1() {
        var p1Password = ""
        var p2Password = "________"
        var inc = 0
        while  p2Password.contains("_") {
            let hash = "\(id)\(inc)".md5Hex()
            if hash.starts(with: "00000") {
                let sixthChar = hash[hash.index(hash.startIndex, offsetBy: 5)]
                if p1Password.count < 8 {
                    p1Password.append(sixthChar)
                }
                if let position = sixthChar.wholeNumberValue, position < p2Password.count {
                    let seventhChar = hash[hash.index(hash.startIndex, offsetBy: 6)]
                    let index = p2Password.index(p2Password.startIndex, offsetBy: position)
                    if p2Password[index] == "_" {
                        p2Password.replace(charAtIndex: index, with: String(seventhChar))
                    }
                }
                print(p1Password)
                print(p2Password)
            }
            inc += 1
        }
        print(p1Password)
        print(p2Password)
    }

    func part2() {
        // WOOT!
    }
}

fileprivate extension String {
    func md5Hex() -> String {
        return Insecure.MD5.hash(data: self.data(using: .utf8)!).map {
            String(format: "%02hhx", $0)
        }.joined()
    }

    mutating func replace(charAtIndex index: String.Index, with char: String) {
        self.replaceSubrange(index...index, with: char)
    }
}
