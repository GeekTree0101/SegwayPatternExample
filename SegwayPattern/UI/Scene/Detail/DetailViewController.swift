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
    case commentHeader
    case comment
  }

  // MARK: UI
  var detailView: DetailView {
    return self.view as! DetailView
  }

  // MARK: Prop
  private let presenter: DetailPresenterLogic
  private let interactor: DetailBusinessLogic

  init(interactor: DetailBusinessLogic, presenter: DetailPresenterLogic) {
    self.interactor = interactor
    self.presenter = presenter
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func loadView() {
    self.view = DetailView().then {
      $0.tableView.dataSource = self
      $0.tableView.delegate = self
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    self.reload()
  }

  @MainActor
  private func reload() {
    Task {
      do {
        // business logic processing
        try await self.interactor.fetch()

        // presentation logic processing
        self.presenter.makeContent()
      } catch {
        self.detailView.showErrorToast(error: error)
      }

      // update UI
      self.detailView.tableView.reloadData()
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
    case .commentHeader:
      return 1
    case .comment:
      return self.presenter.comments.count
    case .none:
      return 0
    }
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    switch Section(rawValue: indexPath.section) {
    case .info:
      if let cell = tableView.dequeueReusableCell(withIdentifier: DetailInfoCell.identifier, for: indexPath) as? DetailInfoCell {
        guard let info = self.presenter.info else { return cell }
        cell.configure(viewModel: info)
        return cell
      }
    case .commentHeader:
      if let cell = tableView.dequeueReusableCell(withIdentifier: DetailCommentHeaderCell.identifier, for: indexPath) as? DetailCommentHeaderCell {
        return cell
      }

    case .comment:
      if let cell = tableView.dequeueReusableCell(withIdentifier: DetailCommentCell.identifier, for: indexPath) as? DetailCommentCell {
        cell.configure(viewModel: self.presenter.comments[indexPath.row])
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
    return UITableView.automaticDimension
  }
}
