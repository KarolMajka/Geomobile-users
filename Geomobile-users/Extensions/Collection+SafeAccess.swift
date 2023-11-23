//
//  Collection+SafeAccess.swift
//  Geomobile-users
//
//  Created by Karol Majka on 23/11/2023.
//

import Foundation

extension Collection {
    subscript(safe index: Index) -> Iterator.Element? {
        index >= startIndex && index < endIndex ? self[index] : nil
    }
}
