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
  var presenter: DetailPresenter!

  override func setUpWithError() throws {
    self.dataStore = DetailDataStoreStub()
    self.presenter = DetailPresenter()
    self.presenter.dataStore = self.dataStore
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }

  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  func test_makeContent_return_expected_info() {
    // given
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
    self.presenter.makeContent()

    // then
    XCTAssertEqual(self.presenter.info?.title, "❤️\ntest")
  }

  func test_makeContent_return_expected_comments() {
    // given
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
    self.presenter.makeContent()

    // then
    XCTAssertEqual(self.presenter.comments.count, 1)
    XCTAssertEqual(self.presenter.comments.first?.content, "test")
    XCTAssertEqual(self.presenter.comments.first?.author, "david")
  }
}
