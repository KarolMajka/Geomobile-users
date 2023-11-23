//
//  AppCoordinator.swift
//  Geomobile-users
//
//  Created by Karol Majka on 23/11/2023.
//

import UIKit

final class AppCoordinator: Coordinator {

    var rootController: UIViewController?
    var presentation: CoordinatorPresentation {
        return dependencies.presentation
    }

    struct Dependencies {
        let presentation: CoordinatorPresentation
    }
    private let dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    func start() {
        let viewModel = UsersListViewModel()
        let viewController = UsersListViewController(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: viewController)
        present(viewController: navigationController)
    }
}
