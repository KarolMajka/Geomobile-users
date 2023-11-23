//
//  UsersListLocalCache.swift
//  Geomobile-users
//
//  Created by Karol Majka on 23/11/2023.
//

import Foundation

final class UsersListLocalCache: UsersListLocalCacheProtocol {

    private static let key = "users_list_data_key"

    private let userDefaults: UserDefaults

    init(
        userDefaults: UserDefaults = .standard
    ) {
        self.userDefaults = userDefaults
    }

    func save(data: [UsersListData]) throws {
        let data = try JSONEncoder().encode(data)
        userDefaults.set(data, forKey: Self.key)
    }

    func load() throws -> [UsersListData]? {
        guard let data = userDefaults.data(forKey: Self.key) else {
            return nil
        }
        return try JSONDecoder().decode([UsersListData].self, from: data)
    }
}
