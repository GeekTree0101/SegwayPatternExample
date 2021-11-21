//
//  FeedViewControllerTests.swift
//  SegwayPatternTests
//
//  Created by Geektree0101 on 2021/11/21.
//

import Foundation
import XCTest
@testable import SegwayPattern

class FeedViewControllerTests: XCTestCase {

  final class FeedInteractorSpy: FeedBusinessLogic {

    var fetchCalled: Int = 0
    var fetchStubError: Error?
    
    func fetch() async throws {
      self.fetchCalled += 1
      guard let error = self.fetchStubError else { return }
      throw error
    }

  }

  final class FeedPresenterSpy: FeedPresentationLogic {

    var headerViewModel: HeaderCell.ViewModel = .init(welcomeMessage: "")

    var feedItems: [FeedCell.ViewModel] = []

    var makeHeaderViewModelCalled: Int = 0

    func makeHeaderViewModel() {
      self.makeHeaderViewModelCalled += 1
    }

    var mappingArticlesToFeedItemsCalled: Int = 0

    func mappingArticlesToFeedItems() {
      self.mappingArticlesToFeedItemsCalled += 1
    }

    var presentDetailIndex: Int?

    func presentDetail(index: Int) {
      self.presentDetailIndex = index
    }

  }

  var interactor: FeedInteractorSpy!
  var presenter: FeedPresenterSpy!

  private func createViewController() -> FeedViewController {
    return FeedViewController(
      interactor: self.interactor,
      presenter: self.presenter
    )
  }

  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.interactor = FeedInteractorSpy()
    self.presenter = FeedPresenterSpy()
  }

  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  @MainActor
  func test_reload_on_success() async {
    // given
    let viewController = self.createViewController()

    // when
    await MainActorTaskBlock {
      viewController.loadViewIfNeeded()
    }

    // then
    XCTAssertEqual(self.interactor.fetchCalled, 1)
    XCTAssertEqual(self.presenter.makeHeaderViewModelCalled, 1)
    XCTAssertEqual(self.presenter.mappingArticlesToFeedItemsCalled, 1)
  }

  @MainActor
  func test_reload_on_failure() async {
    // given
    let viewController = self.createViewController()
    self.interactor.fetchStubError = NSError(domain: "-1", code: -1, userInfo: nil)

    // when
    await MainActorTaskBlock {
      viewController.loadViewIfNeeded()
    }

    // then
    XCTAssertEqual(self.interactor.fetchCalled, 1)
    XCTAssertEqual(self.presenter.makeHeaderViewModelCalled, 0)
    XCTAssertEqual(self.presenter.mappingArticlesToFeedItemsCalled, 0)
  }

}

