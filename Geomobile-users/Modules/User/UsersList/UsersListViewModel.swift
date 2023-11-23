//
//  UsersListViewModel.swift
//  Geomobile-users
//
//  Created by Karol Majka on 23/11/2023.
//

import Foundation
import RxSwift
import RxCocoa
import RxRelay

final class UsersListViewModel {
    let input = Input()
    let output = Output()

    private let disposeBag = DisposeBag()

    private let data: BehaviorRelay<[UsersListData]> = .init(value: [])

    private let service: UsersServiceProtocol
    private let searchFilter: UsersListSearchFilterProtocol
    private let localCache: UsersListLocalCacheProtocol

    init(
        service: UsersServiceProtocol = UsersService(),
        searchFilter: UsersListSearchFilterProtocol = UsersListSearchFilter(),
        localCache: UsersListLocalCacheProtocol = UsersListLocalCache()
    ) {
        self.service = service
        self.searchFilter = searchFilter
        self.localCache = localCache
        setupRxObservers()
    }
}

// MARK: - RxObservers
private extension UsersListViewModel {
    func setupRxObservers() {
        setupViewObservers()
    }

    func setupViewObservers() {
        input.view.fetchData
            .asObservable()
            .subscribe(with: self, onNext: { (self, _) in
                self.fetchUsersData()
            })
            .disposed(by: disposeBag)

        Observable.combineLatest(
            data
                .distinctUntilChanged(),
            input.view.searchText.startWith(nil).distinctUntilChanged()
        )
            .map { [weak self] data, searchText in
                self?.searchFilter.filterResults(data: data, searchText: searchText) ?? []
            }
            .map { $0.map { UsersListCellViewModel(data: $0) } }
            .bind(to: output.view.cellViewModelsSubject)
            .disposed(by: disposeBag)

        input.view.itemSelected
            .compactMap { [weak self] in self?.data.value[safe: $0.row] }
            .subscribe(output.coordinator.showDetailsSubject)
            .disposed(by: disposeBag)
    }
}

// MARK: - Networking
private extension UsersListViewModel {
    func fetchUsersData() {
        let params: UsersListParams = .init(page: 1, per_page: 10)
        service.getUsersList(params: params)
            .trackActivity(output.view.activityIndicator)
            .subscribe(with: self, onSuccess: { (self, response) in
                self.data.accept(response.data)
                try? self.localCache.save(data: response.data)
                self.output.view.errorMessageSubject.onNext(nil)
            }, onFailure: { (self, error) in
                self.output.view.errorMessageSubject.onNext(error.localizedDescription)
                let data = try? self.localCache.load()
                self.data.accept(data ?? [])
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - Input
extension UsersListViewModel {
    struct Input {
        let view = View()

        struct View {
            let fetchData = PublishSubject<Void>()
            let searchText = PublishSubject<String?>()
            let itemSelected = PublishSubject<IndexPath>()
        }
    }
}

// MARK: - Output
extension UsersListViewModel {
    struct Output {
        let view = View()
        let coordinator = Coordinator()

        struct View {
            let activityIndicator = ActivityIndicator()
            var cellViewModels: Driver<[CellViewModel]> { cellViewModelsSubject.asDriver(onErrorJustReturn: []) }
            var errorMessage: Driver<String?> { errorMessageSubject.asDriver(onErrorJustReturn: nil) }

            fileprivate let cellViewModelsSubject = BehaviorSubject<[CellViewModel]>(value: [])
            fileprivate let errorMessageSubject = BehaviorSubject<String?>(value: nil)
        }

        struct Coordinator {
            var showDetails: Driver<UsersListData> { showDetailsSubject.asDriver(onErrorDriveWith: .empty()) }

            fileprivate let showDetailsSubject = PublishSubject<UsersListData>()
        }
    }
}
