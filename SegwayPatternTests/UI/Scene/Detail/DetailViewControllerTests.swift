//
//  DetailViewControllerTests.swift
//  SegwayPatternTests
//
//  Created by Geektree0101 on 2021/11/19.
//

import Foundation
import XCTest
@testable import SegwayPattern

class DetailViewControllerTests: XCTestCase {

  final class DetailInteractorSpy: DetailBusinessLogic {

    var fetchCalled: Int = 0
    var fetchErrorStub: Error?

    func fetch() async throws {
      self.fetchCalled += 1
      guard let error = fetchErrorStub else { return }
      throw error
    }

  }

  final class DetailPresenterSpy: DetailPresenterLogic {

    var info: DetailInfoCell.ViewModel? = nil
    var comments: [DetailCommentCell.ViewModel] = []

    var makeContentCalled: Int = 0

    func makeContent() {
      self.makeContentCalled += 1
    }

  }

  var interactor: DetailInteractorSpy!
  var presenter: DetailPresenterSpy!

  private func createViewController() -> DetailViewController {
    return DetailViewController(
      interactor: self.interactor,
      presenter: self.presenter
    )
  }

  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.interactor = DetailInteractorSpy()
    self.presenter = DetailPresenterSpy()
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
    XCTAssertEqual(self.presenter.makeContentCalled, 1)
  }

  @MainActor
  func test_reload_on_failure() async {
    // given
    let viewController = self.createViewController()
    self.interactor.fetchErrorStub = NSError(domain: "-1", code: -1, userInfo: nil)

    // when
    await MainActorTaskBlock {
      viewController.loadViewIfNeeded()
    }

    // then
    XCTAssertEqual(self.interactor.fetchCalled, 1)
    XCTAssertEqual(self.presenter.makeContentCalled, 0)
  }
  
}

// MARK: - dummy

extension DetailViewController {

  static func dummy() -> DetailViewController {
    return DetailViewController(
      interactor: DetailInteractor.dummy(),
      presenter: DetailPresenter.dummy()
    )
  }
}
