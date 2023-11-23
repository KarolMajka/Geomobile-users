//
//  UsersListSearchFilter.swift
//  Geomobile-users
//
//  Created by Karol Majka on 23/11/2023.
//

import Foundation

final class UsersListSearchFilter: UsersListSearchFilterProtocol {
    func filterResults(data: [UsersListData], searchText: String?) -> [UsersListData] {
        guard let searchText = searchText?.trimmingCharacters(in: .whitespacesAndNewlines).lowercased(),
              !searchText.isEmpty
        else {
            return data
        }

        let searchSplit = searchText
            .split(separator: " ")
            .map { String($0).trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isBlank }

        return data
            .filter { filter(data: $0, searchSplit: searchSplit) }
    }

    private func filter(data: UsersListData, searchSplit: [String]) -> Bool {
        let dataSplit = [
            data.firstName,
            data.lastName,
            data.email
        ]
            .map { $0.split(separator: " ") }
            .flatMap { $0 }
            .map { String($0) }
            .filter { !$0.isBlank }

        return searchSplit
            .allSatisfy { search in
                dataSplit.contains(where: { data in
                    data.range(of: search, options: [.diacriticInsensitive, .caseInsensitive]) != nil
                })
            }
    }
}
