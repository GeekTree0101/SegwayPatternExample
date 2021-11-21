//
//  FeedPresenterTests.swift
//  SegwayPatternTests
//
//  Created by Geektree0101 on 2021/11/21.
//

import Foundation

import Foundation
import XCTest
@testable import SegwayPattern

final class FeedPresenterTests: XCTestCase {

  final class DetailBuilderSpy: DetailBuilder {

    var detailViewControllerByArticleID: Int?
    func detailViewController(articleID: Int) -> DetailViewController {
      self.detailViewControllerByArticleID = articleID
      return DetailViewController.dummy()
    }

  }

  final class FeedDataStoreStub: FeedDataStore {

    var authUser: User? = nil
    var articles: [Article] = []
  }

  var detailBuilder: DetailBuilderSpy!
  var dataStore: FeedDataStoreStub!

  private func createPresenter() -> FeedPresenter {
    let presenter = FeedPresenter(
      detailBuilder: self.detailBuilder
    )
    presenter.dataStore = self.dataStore
    return presenter
  }

  override func setUpWithError() throws {
    self.detailBuilder = DetailBuilderSpy()
    self.dataStore = FeedDataStoreStub()
  }

  func test_makeHeaderViewModel() {
    // given
    let presenter = self.createPresenter()
    self.dataStore.authUser = User(id: 1, name: "david")

    // when
    presenter.makeHeaderViewModel()

    // then
    XCTAssertEqual(
      presenter.headerViewModel.welcomeMessage,
      "Hi david\nWelcome to karrot workshop!"
    )
  }

  func test_mappingArticlesToFeedItems() {
    // given
    let presenter = self.createPresenter()
    self.dataStore.articles = [
      Article(id: 100, title: "", content: "", user: nil, comments: [])
    ]

    // when
    presenter.mappingArticlesToFeedItems()

    // then
    XCTAssertEqual(presenter.feedItems.count, 1)
  }

  func test_presentDetail_with_index() {
    // given
    let presenter = self.createPresenter()
    self.dataStore.articles = [
      Article(id: 1, title: "", content: "", user: nil, comments: []),
      Article(id: 2, title: "", content: "", user: nil, comments: [])
    ]

    // when
    presenter.presentDetail(index: 1)

    // then
    XCTAssertEqual(self.detailBuilder.detailViewControllerByArticleID, 2)
  }

  func test_presentDetail_with_index_but_not_founded() {
    // given
    let presenter = self.createPresenter()
    self.dataStore.articles = []

    // when
    presenter.presentDetail(index: 0)

    // then
    XCTAssertNil(self.detailBuilder.detailViewControllerByArticleID)
  }

}
