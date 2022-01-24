//
//  Puzzle19.swift
//  AOC2016
//
//  Created by Jaydeep Joshi on 02/09/21.
//

fileprivate class Node {
    let id: Int
    var next: Node?
    var prev: Node?

    init(_ id: Int) {
        self.id = id
    }
}

struct Puzzle19: Puzzle {
    private let elfCount = 3001330

    func part1() {
        // Create the linked list
        let start = Node(1)
        var current = start
        for i in 2...elfCount {
            let node = Node(i)
            current.next = node
            if i < elfCount {
                current = node
            } else {
                node.next = start
            }
        }

        // Eliminate elves from linked list till only one left
        current = start
        while current.next!.id != current.id {
            current.next = current.next!.next
            current = current.next!
        }
        print(current.id)
    }

    func part2() {
        // Create doubly linked list
        // We need pointers to both start node and target node
        let start = Node(1)
        var current = start
        var target: Node?
        for i in 2...elfCount {
            let node = Node(i)
            current.next = node
            node.prev = current
            if i < elfCount {
                current = node
            } else {
                node.next = start
                start.prev = node
            }
            if i == elfCount / 2 + 1 {
                target = node
            }
        }

        // Eliminate elves from list till only one left
        var isCountEven = elfCount % 2 == 0
        current = start
        while current.next!.id != current.id {
            target!.next!.prev = target!.prev
            target!.prev!.next = target!.next
            current = current.next!
            target = isCountEven ? target!.next : target!.next!.next
            // isCountEven will always toggle since target node is
            // removed on each loop iteration
            isCountEven.toggle()
        }
        print(current.id)
    }
}
