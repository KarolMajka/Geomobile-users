//
//  Response+ErrorHandling.swift
//  Geomobile-users
//
//  Created by Karol Majka on 23/11/2023.
//

import Moya
import RxSwift

extension PrimitiveSequenceType where Element == Response, Trait == SingleTrait {
    func checkAndParseErrorIfExists() -> Single<Response> {
        return flatMap { response in
            return .just(try response.filterSuccessfulStatusCodes())
        }
    }
}
