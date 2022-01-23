//
//  Puzzle17.swift
//  AOC2016
//
//  Created by Jaydeep Joshi on 02/09/21.
//

import Collections

fileprivate struct Room: Hashable {
    static let S = Room(x: 0, y: 0)
    static let V = Room(x: 3, y: 3)
    let x, y: Int
}

fileprivate struct RoomPath: Hashable {
    private static let passcode = "vkjiggvb"

    let r: Room
    let p: String

    func openNeighbours() -> Set<RoomPath> {
        var open = Set<RoomPath>()
        let openDoors = "\(RoomPath.passcode)\(p)".md5Hex().prefix(4).map { c in
            c == "b" || c == "c" || c == "d" || c == "e" || c == "f"
        }
        if r.y - 1 >= 0 && openDoors[0] {
            open.insert(RoomPath(r: Room(x: r.x, y: r.y - 1), p: p.appending("U")))
        }
        if r.y + 1 <= 3 && openDoors[1] {
            open.insert(RoomPath(r: Room(x: r.x, y: r.y + 1), p: p.appending("D")))
        }
        if r.x - 1 >= 0 && openDoors[2] {
            open.insert(RoomPath(r: Room(x: r.x - 1, y: r.y), p: p.appending("L")))
        }
        if r.x + 1 <= 3 && openDoors[3] {
            open.insert(RoomPath(r: Room(x: r.x + 1, y: r.y), p: p.appending("R")))
        }
        return open
    }
}

struct Puzzle17: Puzzle {

    func part1() {
        print(shortesPath())
    }

    func part2() {
        print(longestPath().count)
    }

    private func shortesPath() -> String {
        let start = RoomPath(r: Room.S, p: "")
        var queue = Deque([start])
        while let current = queue.popFirst() {
            let neighbours = current.openNeighbours()
            for neighbour in neighbours {
                if neighbour.r == Room.V {
                    return neighbour.p
                }
            }
            queue.append(contentsOf: neighbours)
        }
        return "No path found!!!"
    }

    private func longestPath() -> String {
        var longestPath = ""
        let start = RoomPath(r: Room.S, p: "")
        var queue = Deque([start])
        while let current = queue.popFirst() {
            let neighbours = current.openNeighbours()
            for neighbour in neighbours {
                if neighbour.r == Room.V {
                    longestPath = neighbour.p
                } else {
                    queue.append(neighbour)
                }
            }
        }
        return longestPath
    }
}
