//
//  FeedInteractorTests.swift
//  SegwayPatternTests
//
//  Created by Geektree0101 on 2021/11/21.
//

import Foundation
import XCTest
@testable import SegwayPattern

final class FeedInteractorTests: XCTestCase {

  final class ArticleRepositorySpy: ArticleRepository {

    var articlesStub: [Article] = []
    func articles() async -> [Article] {
      return self.articlesStub
    }

    var articleByIDStub: Result<Article, Error> = .failure(NSError(domain: "", code: -1, userInfo: nil))
    func articleByID(_ id: Int) async -> Result<Article, Error> {
      return self.articleByIDStub
    }

  }

  final class UserRepositorySpy: UserRepository {

    var userByIDStub: Result<User, Error> = .failure(NSError(domain: "", code: -1, userInfo: nil))
    func userByID(_ id: Int) async -> Result<User, Error> {
      return self.userByIDStub
    }

    var meStub: User = User(id: 1, name: "teset")
    func me() async -> User {
      return self.meStub
    }

  }

  private var articleRepository: ArticleRepositorySpy!
  private var userRepository: UserRepositorySpy!

  private func createInteractor() -> FeedInteractor {
    let interactor = FeedInteractor(
      articlesUseCase: ArticlesUseCase(
        articleRepository: self.articleRepository
      ),
      authUserUseCase: AuthUserUseCase(
        userRepository: self.userRepository
      )
    )
    return interactor
  }

  override func setUpWithError() throws {
    self.articleRepository = ArticleRepositorySpy()
    self.userRepository = UserRepositorySpy()
  }

  func test_fetch() async throws {
    // given
    let interactor = self.createInteractor()

    self.articleRepository.articlesStub = [
      Article(
        id: 1,
        title: "title",
        content: "content",
        user: nil,
        comments: []
      )
    ]

    self.userRepository.meStub = User(id: 100, name: "david")

    // when
    try await interactor.fetch()

    // then
    XCTAssertEqual(interactor.authUser?.id, 100)
    XCTAssertEqual(interactor.authUser?.name, "david")
    XCTAssertEqual(interactor.articles.count, 1)
  }
}

