//
//  Puzzle04.swift
//  AOC2016
//
//  Created by Jaydeep Joshi on 02/09/21.
//

import Foundation

fileprivate struct Room {
    let name, checksum: String
    let secId: Int
}

struct Puzzle04: Puzzle {
    private let rooms = InputFileReader.read("Input04").map(parseRoom)

    func part1() {
        let validRooms = rooms.filter(isValid)
        let sum = validRooms.reduce(0) { acc, room in
            acc + room.secId
        }
        print(sum)
    }

    func part2() {
        let validRooms = rooms.filter(isValid)
        let decrypted = validRooms.map { room in
            shift(room.name, times: room.secId)
        }
        let secretRoom = validRooms[decrypted.firstIndex(where: { $0.contains("north") })!]
        print(secretRoom.secId)
    }

    private static let pattern = #"(?<name>.+)-(?<secId>[0-9]+)\[(?<checksum>.+)\]"#
    private static let regex = try! NSRegularExpression(pattern: pattern, options: [])

    private static func parseRoom(_ string: String) -> Room {
        let range = NSRange(string.startIndex..<string.endIndex, in: string)
        let match = regex.matches(in: string, options: [], range: range)[0]
        let nameRange = Range(match.range(withName: "name"), in: string)!
        let name = String(string[nameRange])
        let checksumRange = Range(match.range(withName: "checksum"), in: string)!
        let checksum = String(string[checksumRange])
        let secIdRange = Range(match.range(withName: "secId"), in: string)!
        let secId = Int(string[secIdRange])!
        return Room(name: name, checksum: checksum, secId: secId)
    }

    private func charCounts(_ string: String) -> [Character: Int] {
        return string.reduce(into: [Character: Int]()) { dict, c in
            if c != "-" {
                let currentCount = dict[c, default: 0]
                dict[c] = currentCount + 1
            }
        }
    }

    private func isValid(_ room: Room) -> Bool {
        let charCounts = charCounts(room.name)
        let sortedCounts = charCounts.sorted {
            if $0.value != $1.value {
                return $0.value > $1.value
            } else {
                return $0.key < $1.key
            }
        }
        let computed = String(sortedCounts[0..<5].map { $0.key })
        return (computed == room.checksum)
    }

    private func shift(_ s: String, times: Int) -> String {
        let shifted = s.map { char -> Character in
            if char == "-" {
                return " "
            } else {
                return shift(char, times: times)
            }
        }
        return String(shifted)
    }

    private func shift(_ c: Character, times: Int) -> Character {
        let mod = UInt8(times % 26)
        let ascii = c.asciiValue!
        var shiftedAscii = ascii + mod
        if shiftedAscii > 122 {
            shiftedAscii = 97 + (shiftedAscii - 123)
        }
        return Character(UnicodeScalar(shiftedAscii))
    }
}
