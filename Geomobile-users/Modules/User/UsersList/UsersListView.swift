//
//  UsersListView.swift
//  Geomobile-users
//
//  Created by Karol Majka on 23/11/2023.
//

import UIKit
import SnapKit
import KeyboardLayoutGuide
import RxSwift

final class UsersListView: UIView {

    let tableView = UITableView()
    let activityIndicatorView = UIActivityIndicatorView()
    let alertBannerView = AlertBannerView()

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
        addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.left.right.top.equalToSuperview()
            $0.bottom.equalTo(keyboardLayoutGuideNoSafeArea.snp.top)
        }

        addSubview(activityIndicatorView)
        activityIndicatorView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    private func decorateView() {
        tableView.contentInset.bottom = 8
        tableView.contentInset.top = 36

        activityIndicatorView.hidesWhenStopped = true
    }
}
