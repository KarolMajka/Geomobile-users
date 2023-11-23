//
//  PrimitiveSequenceType+ErrorLog.swift
//  Geomobile-users
//
//  Created by Karol Majka on 23/11/2023.
//

import Foundation
import Moya
import RxSwift

extension PrimitiveSequenceType where Trait == SingleTrait {
    func logErrorIfNeeded() -> Single<Element> {
        self.do(onError: { error in
            if let error = error as? MoyaError {
                let statusCode = error.response?.statusCode ?? -1
                print("[ERROR] \(statusCode) \(error.localizedDescription)")
                if let underlyingError = error.errorUserInfo[NSUnderlyingErrorKey] as? Error {
                    print("[ERROR] underlyingError: \(underlyingError.localizedDescription)")
                }
            } else {
                print("[ERROR] \(error.localizedDescription)")
            }
        })
    }
}
