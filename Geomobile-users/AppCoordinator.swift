//
//  AppCoordinator.swift
//  Geomobile-users
//
//  Created by Karol Majka on 23/11/2023.
//

import UIKit
import RxSwift
import RxCocoa

final class AppCoordinator: Coordinator {

    var rootController: UIViewController?
    var presentation: CoordinatorPresentation {
        return dependencies.presentation
    }

    private let disposeBag = DisposeBag()

    struct Dependencies {
        let presentation: CoordinatorPresentation
    }
    private let dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    func start() {
        let viewModel = UsersListViewModel()
        viewModel.output.coordinator.showDetails
            .drive(with: self, onNext: { (self, data) in
                self.showUserDetails(data: data)
            })
            .disposed(by: disposeBag)

        let viewController = UsersListViewController(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: viewController)
        present(viewController: navigationController)
    }

    private func showUserDetails(data: UsersListData) {
        let viewModel = UserDetailsViewModel(data: data)
        let viewController = UserDetailsViewController(viewModel: viewModel)
        rootNavigationController?.pushViewController(viewController, animated: true)
    }
}
