//
//  UsersListTableViewCell.swift
//  Geomobile-users
//
//  Created by Karol Majka on 23/11/2023.
//

import UIKit
import Kingfisher

final class UsersListTableViewCell: UITableViewCell {

    private let avatarImageView = UIImageView()
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.textColor = .primaryText
        label.font = .heading
        return label
    }()
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.textColor = .secondaryText
        label.font = .body
        return label
    }()

    private var viewModel: UsersListCellViewModel?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        viewModel = nil
        avatarImageView.kf.cancelDownloadTask()
        super.prepareForReuse()
    }

    func configure(withViewModel viewModel: UsersListCellViewModel) {
        self.viewModel = viewModel

        avatarImageView.kf.setImage(with: viewModel.output.cell.avatarUrl)
        nameLabel.text = viewModel.output.cell.name
        emailLabel.text = viewModel.output.cell.email
    }

    private func configureLayout() {
        prepareMainStackView()

        let avatarSize: CGFloat = 50
        avatarImageView.snp.makeConstraints {
            $0.size.equalTo(avatarSize)
        }
        avatarImageView.layer.cornerRadius = avatarSize / 2
        avatarImageView.clipsToBounds = true
    }

    private func prepareMainStackView() {
        let mainStackView = UIStackView(arrangedSubviews: [
            avatarImageView,
            prepareLabelsStackView(),
        ])
        mainStackView.axis = .horizontal
        mainStackView.alignment = .center
        mainStackView.spacing = 16

        contentView.addSubview(mainStackView)
        mainStackView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(16)
            $0.top.bottom.equalToSuperview().inset(8)
        }
    }

    private func prepareLabelsStackView() -> UIStackView {
        let labelsStackView = UIStackView(arrangedSubviews: [
            nameLabel,
            emailLabel,
        ])
        labelsStackView.axis = .vertical
        labelsStackView.spacing = 4

        return labelsStackView
    }
}
