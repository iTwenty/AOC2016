//
//  Puzzle11.swift
//  AOC2016
//
//  Created by Jaydeep Joshi on 02/09/21.
//

fileprivate struct Component: Hashable, ExpressibleByStringLiteral {
    let type: Character
    let elem: String

    init(stringLiteral value: StringLiteralType) {
        type = value.last!
        elem = String(value.dropLast())
    }
}

fileprivate struct State {

    static let initial = State(floors: [
        ["prm", "prg"],
        ["cog", "cug", "rug", "plg"],
        ["com", "cum", "rum", "plm"],
        []], elevator: 0)

    let floors: [Set<Component>]
    let elevator: Int

    func isValid() -> Bool {
        floors.allSatisfy(isValidFloor(_:))
    }

    private func isValidFloor(_ components: Set<Component>) -> Bool {
        let rtgs = components.filter { $0.type == "g" }
        if rtgs.isEmpty {
            return true
        }
        let rtgElems = rtgs.map(\.elem)
        let chips = components.subtracting(rtgs)
        for chip in chips {
            if !rtgElems.contains(chip.elem) {
                return false
            }
        }
        return true
    }
}

struct Puzzle11: Puzzle {

    func part1() {
        print(State.initial.isValid())
    }

    func part2() {
    }
}
