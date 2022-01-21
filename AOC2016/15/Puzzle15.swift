//
//  Puzzle15.swift
//  AOC2016
//
//  Created by Jaydeep Joshi on 02/09/21.
//

struct Puzzle15: Puzzle {

    func part1() {
        for i in 0... {
            if isValidTime(i, p2: false) {
                print(i)
                break
            }
        }
    }

    func part2() {
        for i in 0... {
            if isValidTime(i, p2: true) {
                print(i)
                break
            }
        }
    }

    private func isValidTime(_ time: Int, p2: Bool) -> Bool {
        var answer = (time+1) % 7 == 0 &&
                     (time+2) % 13 == 0 &&
                     (time+3) % 3 == 1 &&
                     (time+4) % 5 == 3 &&
                     (time+5) % 17 == 0 &&
                     (time+6) % 19 == 12
        if p2 {
            answer = answer && (time+7) % 11 == 0
        }
        return answer
    }
}
