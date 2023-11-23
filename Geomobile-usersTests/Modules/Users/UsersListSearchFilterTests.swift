//
//  UsersListSearchFilterTests.swift
//  Geomobile-usersTests
//
//  Created by Karol Majka on 23/11/2023.
//

import XCTest

@testable import Geomobile_users

final class UsersListSearchFilterTests: XCTestCase {

    private let sut: UsersListSearchFilterProtocol = UsersListSearchFilter()

    func testEmptySearch() {
        // given
        let searchText = ""
        let data = UsersListData.defaultArray

        // when
        let filteredData = sut.filterResults(data: data, searchText: searchText)

        // then
        XCTAssertEqual(filteredData, data)
    }

    func testNilSearch() {
        // given
        let searchText: String? = nil
        let data = UsersListData.defaultArray

        // when
        let filteredData = sut.filterResults(data: data, searchText: searchText)

        // then
        XCTAssertEqual(filteredData, data)
    }

    func testUppercasedGeorgeFirstNameSearch() {
        // given
        let searchText = "GEORGE"
        let data = UsersListData.defaultArray

        // when
        let filteredData = sut.filterResults(data: data, searchText: searchText)

        // then
        XCTAssertEqual(filteredData, [.georgeBluth])
    }

    func testLowercasedGeorgeLastNameSearch() {
        // given
        let searchText = "george"
        let data = UsersListData.defaultArray

        // when
        let filteredData = sut.filterResults(data: data, searchText: searchText)

        // then
        XCTAssertEqual(filteredData, [.georgeBluth])
    }

    func testWeaverLastNameSearch() {
        // given
        let searchText = "Weaver"
        let data = UsersListData.defaultArray

        // when
        let filteredData = sut.filterResults(data: data, searchText: searchText)

        // then
        XCTAssertEqual(filteredData, [.janetWeaver])
    }

    func testEmailSearch() {
        // given
        let searchText = "emma.wong@reqres.in"
        let data = UsersListData.defaultArray

        // when
        let filteredData = sut.filterResults(data: data, searchText: searchText)

        // then
        XCTAssertEqual(filteredData, [.emmaWong])
    }

    func testBluthSearch() {
        // given
        let searchText = "Bluth"
        let data = UsersListData.defaultArray

        // when
        let filteredData = sut.filterResults(data: data, searchText: searchText)

        // then
        XCTAssertEqual(filteredData, [.georgeBluth, .juliaBluth])
    }

    func testUthSearch() {
        // given
        let searchText = "uth"
        let data = UsersListData.defaultArray

        // when
        let filteredData = sut.filterResults(data: data, searchText: searchText)

        // then
        XCTAssertEqual(filteredData, [.georgeBluth, .juliaBluth])
    }

    func testEmmaWongSearch() {
        // given
        let searchText = "Emma Wong"
        let data = UsersListData.defaultArray

        // when
        let filteredData = sut.filterResults(data: data, searchText: searchText)

        // then
        XCTAssertEqual(filteredData, [.emmaWong])
    }

    func testGeorgeBluthSearch() {
        // given
        let searchText = "George Bluth"
        let data = UsersListData.defaultArray

        // when
        let filteredData = sut.filterResults(data: data, searchText: searchText)

        // then
        XCTAssertEqual(filteredData, [.georgeBluth])
    }
    
    func testBluthGeorgeSearch() {
        // given
        let searchText = "Bluth George"
        let data = UsersListData.defaultArray

        // when
        let filteredData = sut.filterResults(data: data, searchText: searchText)

        // then
        XCTAssertEqual(filteredData, [.georgeBluth])
    }
}
