//
//  DetailInteractorTests.swift
//  SegwayPatternTests
//
//  Created by Geektree0101 on 2021/11/19.
//

import Foundation
import XCTest
@testable import SegwayPattern

class DetailInteractorTests: XCTestCase {

  final class ArticleRepositorySpy: ArticleRepository {

    var articlesStub: [Article] = []
    func articles() async -> [Article] {
      return self.articlesStub
    }

    var articleByIDStub: Result<Article, Error> = .failure(NSError())
    func articleByID(_ id: Int) async -> Result<Article, Error> {
      return self.articleByIDStub
    }

  }

  final class CommentRespositorySpy: CommentRespository {

    var commentsStub: [Comment] = []
    func comments(articleID: Int) async -> [Comment] {
      return self.commentsStub
    }
  }

  var articleRepository: ArticleRepositorySpy!
  var commentRepository: CommentRespositorySpy!


  private func sut(articleID: Int = -1) -> DetailInteractor {
    return DetailInteractor(
      articleID: articleID,
      articleUseCase: ArticleUseCase(
        articleRepository: self.articleRepository
      ),
      commentsUseCase: CommentsUseCase(
        commentRepository: self.commentRepository
      )
    )
  }

  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.articleRepository = ArticleRepositorySpy()
    self.commentRepository = CommentRespositorySpy()
  }

  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  func test_fetch_on_success() async throws {
    // given
    let sut = self.sut(articleID: 1)
    self.articleRepository.articleByIDStub = .success(
      Article(
        id: 1,
        title: "title",
        content: "content",
        user: User(id: 1, name: "name"),
        comments: []
      )
    )
    self.commentRepository.commentsStub = [
      Comment(id: 1, user: nil, content: "1"),
      Comment(id: 1, user: nil, content: "1"),
      Comment(id: 1, user: nil, content: "1")
    ]

    // when
    try? await sut.fetch()

    // then
    XCTAssertEqual(sut.article?.id, 1)
    XCTAssertEqual(sut.article?.title, "title")
    XCTAssertEqual(sut.article?.comments.count, 3)
  }

  func test_fetch_on_failed() async throws {
    // given
    let sut = self.sut(articleID: 1)
    self.articleRepository.articleByIDStub = .failure(NSError(domain: "test", code: 1, userInfo: nil))

    // when
    try? await sut.fetch()

    // then
    XCTAssertNil(sut.article)
  }
}

// MARK: - dummy

extension DetailInteractor {

  static func dummy() -> DetailInteractor {
    return DetailInteractor(
      articleID: -1,
      articleUseCase: ArticleUseCase(
        articleRepository: DetailInteractorTests.ArticleRepositorySpy()
      ),
      commentsUseCase: CommentsUseCase(
        commentRepository: DetailInteractorTests.CommentRespositorySpy()
      )
    )
  }
}
