//
//  UserDetailsView.swift
//  Geomobile-users
//
//  Created by Karol Majka on 23/11/2023.
//

import UIKit

final class UserDetailsView: UIView {

    let avatarImageView = UIImageView()
    let nameLabel: UILabel = {
        let label = UILabel()
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.textColor = .primaryText
        label.font = .heading
        return label
    }()
    let emailLabel: UILabel = {
        let label = UILabel()
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.textColor = .secondaryText
        label.font = .subheading
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
        decorateView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureLayout() {
        let avatarSize: CGFloat = 100
        avatarImageView.snp.makeConstraints {
            $0.size.equalTo(avatarSize)
        }
        avatarImageView.layer.cornerRadius = avatarSize / 2
        avatarImageView.clipsToBounds = true

        let stackView = UIStackView(arrangedSubviews: [
            avatarImageView,
            nameLabel,
            emailLabel,
        ])
        stackView.spacing = 32
        stackView.setCustomSpacing(8, after: nameLabel)
        stackView.axis = .vertical
        stackView.alignment = .center

        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(safeAreaLayoutGuide).inset(64)
        }
    }

    private func decorateView() {
        backgroundColor = .systemBackground
    }
}
