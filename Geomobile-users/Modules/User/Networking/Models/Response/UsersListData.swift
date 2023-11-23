//
//  UsersListData.swift
//  Geomobile-users
//
//  Created by Karol Majka on 23/11/2023.
//

import Foundation

struct UsersListData: Codable, Equatable {
    let id: Int
    let email: String
    let firstName: String
    let lastName: String
    let avatar: URL
}
