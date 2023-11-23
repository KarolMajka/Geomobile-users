//
//  UsersTarget.swift
//  Geomobile-users
//
//  Created by Karol Majka on 23/11/2023.
//

import Moya
import Foundation

enum UsersTarget {
    case usersList(params: UsersListParams)
}

extension UsersTarget: TargetType {
    static let provider = MoyaProvider<Self>()

    var baseURL: URL { Constants.API.baseUrl }

    var path: String { "users" }

    var method: Moya.Method { .get }

    var task: Task {
        switch self {
        case .usersList(let params):
            return .requestParameters(parameters: params.dictionary, encoding: URLEncoding.default)
        }
    }

    var headers: [String: String]? { nil }
}
