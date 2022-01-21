//
//  Puzzle14.swift
//  AOC2016
//
//  Created by Jaydeep Joshi on 02/09/21.
//

import CryptoKit

class Puzzle14: Puzzle {
    private let salt = "yjdafjpo"
    private var md5Cache = [Int: String]()

    func part1() {
        md5Cache.removeAll()
        print(finalIndex(hashing: md5Hash(_:)))
    }

    // Takes ~30mins to run, but produces right answer...eventually
    // Slowness is in CryptoKit MD5 function. Nothing we can do
    func part2() {
        md5Cache.removeAll()
        print(finalIndex(hashing: md5HashStretched(_:)))
    }

    private func finalIndex(hashing: (Int) -> String) -> Int {
        var validKeysCount = 0
        for index in 0... {
            if let repeatedChar = isPotentialKey(index, hashing: hashing) {
                if isDefiniteKey(char: repeatedChar, start: index, hashing: hashing) {
                    validKeysCount += 1
                    print("Key found @ index \(index). Count \(validKeysCount)/64")
                    if validKeysCount == 64 {
                        return index
                    }
                }
            }
        }
        return -1
    }

    private func isPotentialKey(_ index: Int, hashing: (Int) -> String) -> Character? {
        let md5 = hashing(index)
        for i in md5.indices.dropLast(2) {
            let fst = md5[i]
            let mid = md5[md5.index(after: i)]
            let lst = md5[md5.index(i, offsetBy: 2)]
            if fst == mid && fst == lst {
                return fst
            }
        }
        return nil
    }

    private func isDefiniteKey(char: Character, start: Int, hashing: (Int) -> String) -> Bool {
        for index in (start+1)...(start+1000) {
            let md5 = hashing(index)
            for i in md5.indices.dropLast(4) {
                if md5[i] == char &&
                    md5[md5.index(i, offsetBy: 1)] == char &&
                    md5[md5.index(i, offsetBy: 2)] == char &&
                    md5[md5.index(i, offsetBy: 3)] == char &&
                    md5[md5.index(i, offsetBy: 4)] == char {
                    return true
                }
            }
        }
        return false
    }

    private func md5Hash(_ index: Int) -> String {
        if let cached = md5Cache[index] {
            return cached
        }
        let str = "\(salt)\(index)"
        let hash = Insecure.MD5.hash(data: str.data(using: .utf8)!).map {
            String(format: "%02hhx", $0)
        }.joined()
        md5Cache[index] = hash
        return hash
    }

    private func md5HashStretched(_ index: Int) -> String {
        if let cached = md5Cache[index] {
            return cached
        }
        var str = "\(salt)\(index)"
        for _ in 0...2016 {
            str = Insecure.MD5.hash(data: str.data(using: .utf8)!).map {
                String(format: "%02hhx", $0)
            }.joined()
        }
        md5Cache[index] = str
        return str
    }
}
