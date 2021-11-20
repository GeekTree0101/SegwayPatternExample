//
//  DetailPresenterTests.swift
//  SegwayPatternTests
//
//  Created by Geektree0101 on 2021/11/19.
//

import Foundation
import XCTest
@testable import SegwayPattern

class DetailPresenterTests: XCTestCase {

  final class DetailDataStoreStub: DetailDataStore {

    var article: Article?
  }

  var dataStore: DetailDataStoreStub!

  override func setUpWithError() throws {
    self.dataStore = DetailDataStoreStub()
  }

  private func createPresenter() -> DetailPresenter {
    let presenter = DetailPresenter()
    presenter.dataStore = self.dataStore
    return presenter
  }

  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  func test_makeContent_return_expected_info() {
    // given
    let presenter = self.createPresenter()

    self.dataStore.article = Article(
      id: 1,
      title: "test",
      content: "test",
      user: User(id: 1, name: "david"),
      comments: [
        Comment(id: 1, user: User(id: 1, name: "david"), content: "test")
      ]
    )

    // when
    presenter.makeContent()

    // then
    XCTAssertEqual(presenter.info?.title, "❤️\ntest")
  }

  func test_makeContent_return_expected_comments() {
    // given
    let presenter = self.createPresenter()

    self.dataStore.article = Article(
      id: 1,
      title: "test",
      content: "test",
      user: User(id: 1, name: "david"),
      comments: [
        Comment(id: 1, user: User(id: 1, name: "david"), content: "test")
      ]
    )

    // when
    presenter.makeContent()

    // then
    XCTAssertEqual(presenter.comments.count, 1)
    XCTAssertEqual(presenter.comments.first?.content, "test")
    XCTAssertEqual(presenter.comments.first?.author, "david")
  }
}
