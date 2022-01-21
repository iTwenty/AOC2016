//
//  Puzzle16.swift
//  AOC2016
//
//  Created by Jaydeep Joshi on 02/09/21.
//

struct Puzzle16: Puzzle {
    private let input = "11101000110010100"

    func part1() {
        print(checkSum(randomData(input, size: 272)))
    }

    // Takes ~30 secs to run on M1 Macbook Air
    func part2() {
        print(checkSum(randomData(input, size: 35651584)))
    }

    private func randomData(_ initial: String, size: Int) -> String {
        var a = initial
        while a.count < size {
            var b = ""
            for c in a {
                if c == "0" {
                    b.append("1")
                } else {
                    b.append("0")
                }
            }
            a = "\(a)0\(String(b.reversed()))"
        }
        return String(a[a.startIndex..<a.index(a.startIndex, offsetBy: size)])
    }

    private func checkSum(_ str: String) -> String {
        var checksum = Array(str)
        while checksum.count % 2 == 0 {
            let chunks = checksum.chunks(ofCount: 2)
            checksum = chunks.map { chunk -> Character in
                if chunk.first! == chunk.last! {
                    return "1"
                } else {
                    return "0"
                }
            }
        }
        return String(checksum)
    }
}
