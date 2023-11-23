//
//  UsersListLocalCacheProtocol.swift
//  Geomobile-users
//
//  Created by Karol Majka on 23/11/2023.
//

import Foundation

// sourcery: AutoMockable
protocol UsersListLocalCacheProtocol {
    func save(data: [UsersListData]) throws
    func load() throws -> [UsersListData]?
}
