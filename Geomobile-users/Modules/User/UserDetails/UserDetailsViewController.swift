//
//  UserDetailsViewController.swift
//  Geomobile-users
//
//  Created by Karol Majka on 23/11/2023.
//

import UIKit

final class UserDetailsViewController: UIViewController {
    
    private lazy var contentView = UserDetailsView()

    private let viewModel: UserDetailsViewModel

    init(viewModel: UserDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }

    private func bindViewModel() {
        contentView.avatarImageView.kf.setImage(with: viewModel.output.view.avatarUrl)
        contentView.nameLabel.text = viewModel.output.view.name
        contentView.emailLabel.text = viewModel.output.view.email

        navigationItem.title = viewModel.output.view.name
    }
}
