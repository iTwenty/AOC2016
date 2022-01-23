//
//  Extensions.swift
//  AOC2016
//
//  Created by Jaydeep Joshi on 23/01/22.
//

import Foundation
import CryptoKit

extension String {
    func md5Hex() -> String {
        return Insecure.MD5.hash(data: self.data(using: .utf8)!).map {
            String(format: "%02hhx", $0)
        }.joined()
    }

    mutating func replace(charAtIndex index: String.Index, with char: String) {
        self.replaceSubrange(index...index, with: char)
    }
}
