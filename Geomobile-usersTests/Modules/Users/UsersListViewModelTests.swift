//
//  UsersListViewModelTests.swift
//  Geomobile-usersTests
//
//  Created by Karol Majka on 23/11/2023.
//

import XCTest
import SwiftyMocky
import RxSwift
import RxTest
import RxBlocking

@testable import Geomobile_users

final class UsersListViewModelTests: XCTestCase {

    enum Error: Swift.Error {
        case testError
    }

    private let serviceMock = UsersServiceProtocolMock()
    private let searchFilterMock = UsersListSearchFilterProtocolMock()
    private let localCacheMock = UsersListLocalCacheProtocolMock()

    private var disposeBag = DisposeBag()
    private var scheduler = TestScheduler(initialClock: 0)

    private var cellViewModelsTestableObserver: TestableObserver<Int>!
    private var activityIndicatorTestableObserver: TestableObserver<Bool>!
    private var errorMessageTestableObserver: TestableObserver<String?>!

    private var sut: UsersListViewModel!

    func testFetchDataSuccess() {
        // given
        let response = UsersListResponse.defaultResponse
        serviceMock.given(.getUsersList(params: .any, willReturn: .just(response)))
        searchFilterMock.given(.filterResults(data: .value(response.data), searchText: .any, willReturn: response.data))
        searchFilterMock.given(.filterResults(data: .value([]), searchText: .any, willReturn: []))
        localCacheMock.given(.save(data: .any, willProduce: { stub in
            stub.return(())
        }))

        // when
        buildSUT()
        scheduler.createColdObservable([
            .next(1, ()),
        ])
            .bind(to: sut.input.view.fetchData)
            .disposed(by: disposeBag)
        scheduler.start()

        // then
        XCTAssertEqual(cellViewModelsTestableObserver.events, [
            .next(0, 0),
            .next(1, response.data.count),
        ])
        serviceMock.verify(.getUsersList(params: .value(.init(page: 1, per_page: 10))), count: .once)
        searchFilterMock.verify(.filterResults(data: .any, searchText: .value(nil)), count: .exactly(2))
        localCacheMock.verify(.save(data: .value(response.data)), count: .once)
    }

    func testFetchDataFailureWithLocalCache() {
        // given
        let response = UsersListResponse.defaultResponse
        serviceMock.given(.getUsersList(params: .any, willReturn: .error(Error.testError)))
        searchFilterMock.given(.filterResults(data: .value(response.data), searchText: .any, willReturn: response.data))
        searchFilterMock.given(.filterResults(data: .value([]), searchText: .any, willReturn: []))
        localCacheMock.given(.load(willReturn: response.data))

        // when
        buildSUT()
        scheduler.createColdObservable([
            .next(1, ()),
        ])
            .bind(to: sut.input.view.fetchData)
            .disposed(by: disposeBag)
        scheduler.start()

        // then
        XCTAssertEqual(cellViewModelsTestableObserver.events, [
            .next(0, 0),
            .next(1, response.data.count),
        ])
        serviceMock.verify(.getUsersList(params: .value(.init(page: 1, per_page: 10))), count: .once)
        searchFilterMock.verify(.filterResults(data: .any, searchText: .value(nil)), count: .exactly(2))
        localCacheMock.verify(.load(), count: .once)
    }

    func testFetchDataFailureWithoutLocalCache() {
        // given
        let response = UsersListResponse.defaultResponse
        serviceMock.given(.getUsersList(params: .any, willReturn: .error(Error.testError)))
        searchFilterMock.given(.filterResults(data: .value(response.data), searchText: .any, willReturn: response.data))
        searchFilterMock.given(.filterResults(data: .value([]), searchText: .any, willReturn: []))
        localCacheMock.given(.load(willReturn: nil))

        // when
        buildSUT()
        scheduler.createColdObservable([
            .next(1, ()),
        ])
            .bind(to: sut.input.view.fetchData)
            .disposed(by: disposeBag)
        scheduler.start()

        // then
        XCTAssertEqual(cellViewModelsTestableObserver.events, [
            .next(0, 0),
        ])
        serviceMock.verify(.getUsersList(params: .value(.init(page: 1, per_page: 10))), count: .once)
        searchFilterMock.verify(.filterResults(data: .any, searchText: .value(nil)), count: .exactly(1))
        localCacheMock.verify(.load(), count: .once)
    }

    func testSearch() {
        // given
        let response = UsersListResponse.defaultResponse
        serviceMock.given(.getUsersList(params: .any, willReturn: .just(response)))
        searchFilterMock.given(.filterResults(data: .value(response.data), searchText: .any, willReturn: response.data))
        searchFilterMock.given(.filterResults(data: .value(response.data), searchText: .matching { !($0?.isBlank ?? true) }, willReturn: [response.data[0]]))
        searchFilterMock.given(.filterResults(data: .value([]), searchText: .any, willReturn: []))
        localCacheMock.given(.save(data: .any, willProduce: { stub in
            stub.return(())
        }))

        // when
        buildSUT()
        scheduler.createColdObservable([
            .next(3, ()),
        ])
            .bind(to: sut.input.view.fetchData)
            .disposed(by: disposeBag)
        scheduler.createColdObservable([
            .next(1, "George"),
            .next(2, nil),
            .next(4, "George"),
            .next(5, nil),
        ])
            .bind(to: sut.input.view.searchText)
            .disposed(by: disposeBag)
        scheduler.start()

        // then
        XCTAssertEqual(cellViewModelsTestableObserver.events, [
            .next(0, 0),
            .next(1, 0),
            .next(2, 0),
            .next(3, response.data.count),
            .next(4, 1),
            .next(5, response.data.count),
        ])
        serviceMock.verify(.getUsersList(params: .value(.init(page: 1, per_page: 10))), count: .once)
        searchFilterMock.verify(.filterResults(data: .any, searchText: .value(nil)), count: .exactly(4))
        localCacheMock.verify(.save(data: .value(response.data)), count: .once)
    }

    private func buildSUT() {
        sut = UsersListViewModel(
            service: serviceMock,
            searchFilter: searchFilterMock,
            localCache: localCacheMock
        )

        configureTestableObservers()
    }

    private func configureTestableObservers() {
        cellViewModelsTestableObserver = scheduler.createObserver(Int.self)
        sut.output.view.cellViewModels
            .map { $0.count }
            .drive(cellViewModelsTestableObserver)
            .disposed(by: disposeBag)

        activityIndicatorTestableObserver = scheduler.createObserver(Bool.self)
        sut.output.view.activityIndicator
            .drive(activityIndicatorTestableObserver)
            .disposed(by: disposeBag)

        errorMessageTestableObserver = scheduler.createObserver(String?.self)
        sut.output.view.errorMessage
            .drive(errorMessageTestableObserver)
            .disposed(by: disposeBag)
    }
}
