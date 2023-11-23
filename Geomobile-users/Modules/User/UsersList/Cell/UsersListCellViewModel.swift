//
//  UsersListCellViewModel.swift
//  Geomobile-users
//
//  Created by Karol Majka on 23/11/2023.
//

import Foundation

final class UsersListCellViewModel: CellViewModel {
    let output: Output

    init(data: UsersListData) {
        output = .init(cell: .init(
            avatarUrl: data.avatar,
            name: "\(data.firstName) \(data.lastName)",
            email: data.email
        ))
    }
}

// MARK: - Output
extension UsersListCellViewModel {
    struct Output {
        let cell: Cell

        struct Cell {
            let avatarUrl: URL
            let name: String
            let email: String
        }
    }
}
