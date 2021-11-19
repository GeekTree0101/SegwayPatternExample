//
//  DetailViewController.swift
//  SegwayPattern
//
//  Created by Geektree0101 on 2021/11/18.
//

import Foundation
import UIKit

final class DetailViewController: UIViewController {

  enum Section: Int, CaseIterable {
    case info
    case comment
  }

  // MARK: UI
  var detailView: DetailView {
    return self.view as! DetailView
  }

  // MARK: Prop
  private var presenter: DetailPresenterLogic?
  private var interactor: DetailBusinessLogic?

  init(articleID: Int) {
    super.init(nibName: nil, bundle: nil)
    self.configure(articleID: articleID)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configure(articleID: Int) {
    let viewController = self
    let interactor = DetailInteractor(
      articleID: articleID,
      articleUseCase: ArticleUseCase(
        articleRepository: DefaultArticleRepository()
      ),
      commentsUseCase: CommentsUseCase(
        commentRepository: DefaultCommentRespository()
      )
    )
    let presenter = DetailPresenter()

    presenter.dataStore = interactor
    presenter.viewController = viewController

    viewController.interactor = interactor
    viewController.presenter = presenter
  }

  override func loadView() {
    let detailView = DetailView()
    detailView.tableView.dataSource = self
    detailView.tableView.delegate = self
    self.view = detailView
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
        try await self.interactor?.fetch()
        try await self.interactor?.fetch()
        try await self.interactor?.fetch()
        try await self.interactor?.fetch()
        try await self.interactor?.fetch()
        try await self.interactor?.fetch()
        try await self.interactor?.fetch()

        // presentation logic processing
        self.presenter?.makeContent()

        // update UI
        self.detailView.tableView.reloadData()
      } catch {
        fatalError()
      }
    }
  }
}

// MARK: - UITableViewDataSource

extension DetailViewController: UITableViewDataSource {

  func numberOfSections(in tableView: UITableView) -> Int {
    return Section.allCases.count
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch Section(rawValue: section) {
    case .info:
      return 1
    case .comment:
      return self.presenter?.comments.count ?? 0
    case .none:
      return 0
    }
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    switch Section(rawValue: indexPath.section) {
    case .info:
      if let cell = tableView.dequeueReusableCell(withIdentifier: DetailInfoCell.identifier, for: indexPath) as? DetailInfoCell {
        guard let info = self.presenter?.info else { return cell }
        cell.configure(viewModel: info)
        return cell
      }

    case .comment:
      if let cell = tableView.dequeueReusableCell(withIdentifier: DetailCommentCell.identifier, for: indexPath) as? DetailCommentCell {
        guard let comment = self.presenter?.comments[indexPath.row] else { return cell }
        cell.configure(viewModel: comment)
        return cell
      }

    case .none:
      break
    }

    return UITableViewCell()
  }

}

extension DetailViewController: UITableViewDelegate {

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

    switch Section(rawValue: indexPath.section) {
    case .info:
      return 240.0

    case .comment:
      return 80.0

    case .none:
      break
    }

    return 0.0
  }
}
