//
//  UsersService.swift
//  Geomobile-users
//
//  Created by Karol Majka on 23/11/2023.
//

import Moya
import RxMoya
import RxSwift

// sourcery: AutoMockable
protocol UsersServiceProtocol {
    func getUsersList(params: UsersListParams) -> Single<UsersListResponse>
}

final class UsersService: UsersServiceProtocol {

    private let provider: MoyaProvider<UsersTarget>

    init(provider: MoyaProvider<UsersTarget> = .init()) {
        self.provider = provider
    }

    func getUsersList(params: UsersListParams) -> Single<UsersListResponse> {
        provider.rx.request(.usersList(params: params))
            .checkAndParseErrorIfExists()
            .map(UsersListResponse.self, using: .default)
            .logErrorIfNeeded()
    }
}
