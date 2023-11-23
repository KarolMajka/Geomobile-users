//
//  UserDetailsViewModel.swift
//  Geomobile-users
//
//  Created by Karol Majka on 23/11/2023.
//

import Foundation

final class UserDetailsViewModel {

    fileprivate(set) var output = Output()

    init(data: UsersListData) {
        output.view.avatarUrl = data.avatar
        output.view.name = "\(data.firstName) \(data.lastName)"
        output.view.email = data.email
    }
}

// MARK: - Output
extension UserDetailsViewModel {
    struct Output {
        fileprivate(set) var view = View()

        struct View {
            fileprivate(set) var avatarUrl: URL?
            fileprivate(set) var name: String?
            fileprivate(set) var email: String?
        }
    }
}
