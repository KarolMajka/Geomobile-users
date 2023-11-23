//
//  UsersListLocalCacheTests.swift
//  Geomobile-usersTests
//
//  Created by Karol Majka on 23/11/2023.
//

import XCTest

@testable import Geomobile_users

final class UsersListLocalCacheTests: XCTestCase {

    private let sut: UsersListLocalCacheProtocol = UsersListLocalCache()

    override func setUp() {
        super.setUp()
        UserDefaults.standard.removeObject(forKey: "users_list_data_key")
    }

    func testLoadInitialLocalCache() throws {
        // given

        // when
        let data = try sut.load()

        // then
        XCTAssertEqual(data, nil)
    }

    func testSaveEmptyArrayToLocalCache() throws {
        // given
        let dataToSave: [UsersListData] = []

        // when
        try sut.save(data: dataToSave)
        let loadedData = try sut.load()

        // then
        XCTAssertEqual(dataToSave, loadedData)
    }

    func testSaveDataToLocalCache() throws {
        // given
        let dataToSave = UsersListData.defaultArray

        // when
        try sut.save(data: dataToSave)
        let loadedData = try sut.load()

        // then
        XCTAssertEqual(dataToSave, loadedData)
    }
}
