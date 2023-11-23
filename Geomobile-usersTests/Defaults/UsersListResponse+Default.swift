//
//  UsersListResponse+Default.swift
//  Geomobile-usersTests
//
//  Created by Karol Majka on 23/11/2023.
//

import Foundation

@testable import Geomobile_users

extension UsersListResponse {
    static var defaultResponse: Self {
        UsersListResponse(
            page: 1,
            perPage: 10,
            total: 12, 
            totalPages: 2,
            data: UsersListData.defaultArray
        )
    }
}
