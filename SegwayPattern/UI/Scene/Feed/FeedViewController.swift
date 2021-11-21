//
//  FeedViewController.swift
//  SegwayPattern
//
//  Created by Geektree0101 on 2021/11/18.
//

import UIKit

final class FeedViewController: UIViewController {

  enum Section: Int, CaseIterable {
    case header
    case item
  }

  // MARK: UI
  var feedView: FeedView {
    return self.view as! FeedView
  }

  // MARK: Prop
  private let presenter: FeedPresentationLogic
  private let interactor: FeedBusinessLogic

  init(interactor: FeedBusinessLogic, presenter: FeedPresentationLogic) {
    self.interactor = interactor
    self.presenter = presenter
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func loadView() {
    self.view = FeedView().then {
      $0.tableView.dataSource = self
      $0.tableView.delegate = self
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    self.reload()
  }

  @MainActor
  func reload() {
    Task {
      do {
        // business logic processing
        try await self.interactor.fetch()

        // presentation logic processing
        self.presenter.makeHeaderViewModel()
        self.presenter.mappingArticlesToFeedItems()

      } catch {
        self.feedView.showErrorToast(error: error)
      }

      // update UI
      self.feedView.tableView.reloadData()
    }
  }

}

// MARK: - UITableViewDataSource

extension FeedViewController: UITableViewDataSource {

  func numberOfSections(in tableView: UITableView) -> Int {
    return Section.allCases.count
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch Section(rawValue: section) {
    case .header:
      return 1
    case .item:
      return self.presenter.feedItems.count
    case .none:
      return 0
    }
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    switch Section(rawValue: indexPath.section) {
    case .header:
      if let cell = tableView.dequeueReusableCell(withIdentifier: HeaderCell.identifier, for: indexPath) as? HeaderCell {
        cell.configure(viewModel: self.presenter.headerViewModel)
        return cell
      }
      
    case .item:
      if let cell = tableView.dequeueReusableCell(withIdentifier: FeedCell.identifier, for: indexPath) as? FeedCell {
        cell.configure(viewModel: self.presenter.feedItems[indexPath.row])
        return cell
      }

    case .none:
      break
    }

    return UITableViewCell()
  }

}

extension FeedViewController: UITableViewDelegate {

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.cellForRow(at: indexPath)?.isSelected = false
    switch Section(rawValue: indexPath.section) {
    case .header:
      break
    case .item:
      self.presenter.presentDetail(index: indexPath.item)
    case .none:
      break
    }
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
}
