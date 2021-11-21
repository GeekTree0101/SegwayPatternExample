//
//  FeedPresenter.swift
//  SegwayPattern
//
//  Created by Geektree0101 on 2021/11/18.
//

import Foundation

protocol FeedPresentationLogic {

  var headerViewModel: HeaderCell.ViewModel { get }
  var feedItems: [FeedCell.ViewModel] { get }
  func makeHeaderViewModel()
  func mappingArticlesToFeedItems()
  func presentDetail(index: Int)
}

final class FeedPresenter: FeedPresentationLogic {

  weak var dataStore: FeedDataStore!
  weak var viewController: FeedViewController?

  var headerViewModel: HeaderCell.ViewModel = .init(welcomeMessage: "Loading...")
  var feedItems: [FeedCell.ViewModel] = []

  private let detailBuilder: DetailBuilder

  init(detailBuilder: DetailBuilder) {
    self.detailBuilder = detailBuilder
  }

  func makeHeaderViewModel() {
    let name = self.dataStore.authUser?.name ?? "???"
    self.headerViewModel = .init(
      welcomeMessage: "Hi \(name)\nWelcome to karrot workshop!"
    )
  }

  func mappingArticlesToFeedItems() {
    self.feedItems = self.dataStore.articles.map {
      return FeedCell.ViewModel(
        title: $0.title,
        desc: "\"\($0.content)\"",
        author: "Created by \( $0.user?.name ?? "???")"
      )
    }
  }

  func presentDetail(index: Int) {
    guard self.dataStore.articles.count > index else { return }
    let article = self.dataStore.articles[index]
    let detailViewController =  self.detailBuilder.detailViewController(articleID: article.id)
    self.viewController?.present(detailViewController, animated: true, completion: nil)
  }

}
