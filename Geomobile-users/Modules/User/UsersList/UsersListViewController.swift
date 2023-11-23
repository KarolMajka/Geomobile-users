//
//  UsersListViewController.swift
//  Geomobile-users
//
//  Created by Karol Majka on 23/11/2023.
//

import UIKit
import SnapKit
import KeyboardLayoutGuide
import RxSwift

final class UsersListViewController: UIViewController {

    private lazy var contentView = UsersListView()
    private let searchController = UISearchController()

    private let disposeBag = DisposeBag()
    private let viewModel: UsersListViewModel

    init(viewModel: UsersListViewModel) {
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
        decorateView()
        registerCells()
        prepareRxObservers()
        viewModel.input.view.fetchData.onNext(())
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if contentView.alertBannerView.superview == nil {
            contentView.alertBannerView.addToViewController(self)
        }
    }

    private func decorateView() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = L10n.UsersList.viewTitle
        navigationItem.searchController = searchController
    }

    private func registerCells() {
        contentView.tableView.register(UsersListTableViewCell.self)
    }

    private func prepareRxObservers() {
        viewModel.output.view.cellViewModels
            .drive(contentView.tableView.rx.items) { tableView, row, cellViewModel in
                let indexPath = IndexPath(row: row, section: 0)
                switch cellViewModel {
                case let cellViewModel as UsersListCellViewModel:
                    let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as UsersListTableViewCell
                    cell.configure(withViewModel: cellViewModel)
                    return cell
                default:
                    print("Unhandled CellViewModel type: \(cellViewModel.self).")
                    return UITableViewCell()
                }
            }
            .disposed(by: disposeBag)

        viewModel.output.view.activityIndicator
            .drive(contentView.activityIndicatorView.rx.isAnimating)
            .disposed(by: disposeBag)

        viewModel.output.view.errorMessage
            .drive(with: self, onNext: { (self, errorMessage) in
                if let errorMessage = errorMessage {
                    self.contentView.alertBannerView.setErrorMessage(errorMessage)
                    self.contentView.alertBannerView.layoutIfNeeded()
                    self.contentView.alertBannerView.present()
                } else {
                    self.contentView.alertBannerView.dismiss()
                }
            })
            .disposed(by: disposeBag)

        searchController.searchBar.rx.text
            .bind(to: viewModel.input.view.searchText)
            .disposed(by: disposeBag)
    }
}
