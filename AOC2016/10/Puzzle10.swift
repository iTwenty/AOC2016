//
//  Puzzle10.swift
//  AOC2016
//
//  Created by Jaydeep Joshi on 02/09/21.
//

fileprivate typealias Bot = Int
fileprivate typealias Output = Int
fileprivate typealias Chip = Int
fileprivate typealias Action = (receiver: Receiver, id: Int)

fileprivate enum Receiver: String {
    case output, bot
}

struct Puzzle10: Puzzle {
    private var bots: [Bot: [Chip]] = [:]
    private var outputs: [Output: Chip] = [:]
    private var actions: [Bot: (lo: Action, hi: Action)] = [:]

    init() {
        InputFileReader.read("Input10").forEach { line in
            let split = line.split(separator: " ")
            if split.count == 6 {
                let chip = Int(split[1])!
                let bot = Int(split[5])!
                var botChips = bots[bot, default: []]
                botChips.append(chip)
                bots[bot] = botChips
            } else {
                let bot = Int(split[1])!
                let loReceiver = Receiver(rawValue: String(split[5]))!
                let loId = Int(split[6])!
                let hiReceiver = Receiver(rawValue: String(split[10]))!
                let hiId = Int(split[11])!
                actions[bot] = ((loReceiver, loId), (hiReceiver, hiId))
            }
        }
    }

    func part1() {
        var currentBots = bots
        var currentOutputs = outputs
        while !currentBots.isEmpty {
            var newBots = currentBots
            var newOutputs = currentOutputs
            let fullBots = currentBots.filter { $0.value.count == 2 }
            fullBots.forEach { fullBot in
                let lo = fullBot.value.min()!
                let hi = fullBot.value.max()!
                if lo == 17, hi == 61 {
                    print(fullBot.key)
                }
                newBots[fullBot.key] = nil
                let action = actions[fullBot.key]!
                performAction(action.lo, chip: lo, bots: &newBots, outputs: &newOutputs)
                performAction(action.hi, chip: hi, bots: &newBots, outputs: &newOutputs)
            }
            currentBots = newBots
            currentOutputs = newOutputs
        }
        print(currentOutputs[0]! * currentOutputs[1]! * currentOutputs[2]!)
    }

    func part2() { }

    private func performAction(_ action: Action, chip: Chip, bots: inout [Bot: [Chip]], outputs: inout [Output: Chip]) {
        switch action.receiver {
        case .output:
            outputs[action.id] = chip
        case .bot:
            var botChips = bots[action.id, default: []]
            botChips.append(chip)
            bots[action.id] = botChips
        }
    }
}
