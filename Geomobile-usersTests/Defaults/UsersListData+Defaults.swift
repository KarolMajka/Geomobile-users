//
//  UsersListData+Defaults.swift
//  Geomobile-usersTests
//
//  Created by Karol Majka on 23/11/2023.
//

import Foundation

@testable import Geomobile_users

extension UsersListData {
    static var georgeBluth: Self {
        .init(
            id: 1,
            email: "george.bluth@reqres.in", 
            firstName: "George",
            lastName: "Bluth",
            avatar: URL(string: "https://reqres.in/img/faces/1-image.jpg")!
        )
    }

    static var janetWeaver: Self {
        .init(
            id: 2,
            email: "janet.weaver@reqres.in", 
            firstName: "Janet",
            lastName: "Weaver",
            avatar: URL(string: "https://reqres.in/img/faces/2-image.jpg")!
        )
    }

    static var emmaWong: Self {
        .init(
            id: 3,
            email: "emma.wong@reqres.in", 
            firstName: "Emma",
            lastName: "Wong",
            avatar: URL(string: "https://reqres.in/img/faces/3-image.jpg")!
        )
    }

    static var juliaBluth: Self {
        .init(
            id: 4,
            email: "julia.bluth@reqres.in", 
            firstName: "Julia",
            lastName: "Bluth",
            avatar: URL(string: "https://reqres.in/img/faces/4-image.jpg")!
        )
    }

    static var defaultArray: [Self] {
        [
            georgeBluth,
            emmaWong,
            janetWeaver,
            juliaBluth,
        ]
    }
}
