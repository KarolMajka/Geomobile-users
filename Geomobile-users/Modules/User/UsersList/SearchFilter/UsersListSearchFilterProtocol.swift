//
//  UsersListSearchFilterProtocol.swift
//  Geomobile-users
//
//  Created by Karol Majka on 23/11/2023.
//

import Foundation

// sourcery: AutoMockable
protocol UsersListSearchFilterProtocol {
    func filterResults(data: [UsersListData], searchText: String?) -> [UsersListData]
}
