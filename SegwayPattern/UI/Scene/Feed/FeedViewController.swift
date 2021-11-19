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
  private var presenter: FeedPresentationLogic!
  private var interactor: FeedBusinessLogic!

  init() {
    super.init(nibName: nil, bundle: nil)
    self.configure()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configure() {
    let viewController = self
    let interactor = FeedInteractor(
      articlesUseCase: ArticlesUseCase(
        articleRepository: DefaultArticleRepository()
      ),
      authUserUseCase: AuthUserUseCase(
        userRepository: DefaultUserRepository()
      )
    )

    let presenter = FeedPresenter()

    presenter.dataStore = interactor
    presenter.viewController = viewController

    viewController.interactor = interactor
    viewController.presenter = presenter
  }

  override func loadView() {
    let feedView = FeedView()
    feedView.tableView.dataSource = self
    feedView.tableView.delegate = self
    self.view = feedView
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    self.reload()
  }

  @MainActor
  func reload() {
    Task {
      // business logic processing
      await self.interactor.fetch()

      // presentation logic processing
      self.presenter.makeHeaderViewModel()
      self.presenter.mappingArticlesToFeedItems()

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
    switch Section(rawValue: indexPath.section) {
    case .header:
      return 240
    case .item:
      return 120
    case .none:
      return 0
    }
  }
}
