//
//  UsersListCellViewModelTests.swift
//  Geomobile-usersTests
//
//  Created by Karol Majka on 23/11/2023.
//

import XCTest

@testable import Geomobile_users

final class UsersListCellViewModelTests: XCTestCase {

    private var sut: UsersListCellViewModel!

    func testGeorgeBluthData() {
        // given
        let data = UsersListData.georgeBluth

        // when
        buildSUT(data: data)

        // then
        XCTAssertEqual(sut.output.cell.avatarUrl, data.avatar)
        XCTAssertEqual(sut.output.cell.email, data.email)
        XCTAssertEqual(sut.output.cell.name, "\(data.firstName) \(data.lastName)")
    }

    private func buildSUT(data: UsersListData) {
        sut = UsersListCellViewModel(data: data)
    }
}
