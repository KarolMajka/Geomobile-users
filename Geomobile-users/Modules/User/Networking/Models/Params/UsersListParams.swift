//
//  UsersListParams.swift
//  Geomobile-users
//
//  Created by Karol Majka on 23/11/2023.
//

import Foundation

struct UsersListParams: NetworkingParams, Equatable {
    let page: Int
    let per_page: Int
}
