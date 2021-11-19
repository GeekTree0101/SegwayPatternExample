//
//  DetailInteractor.swift
//  SegwayPattern
//
//  Created by Geektree0101 on 2021/11/18.
//

import Foundation

protocol DetailDataStore: AnyObject {

  var article: Article? { get }
}

protocol DetailBusinessLogic: AnyObject {

  func fetch() async throws
}

final class DetailInteractor: DetailDataStore {

  // MARK: - deps
  private let articleUseCase: ArticleUseCase
  private let commentsUseCase: CommentsUseCase

  // MARK: - props
  var article: Article?
  private let articleID: Int

  init(articleID: Int,
       articleUseCase: ArticleUseCase,
       commentsUseCase: CommentsUseCase) {
    self.articleID = articleID
    self.articleUseCase = articleUseCase
    self.commentsUseCase = commentsUseCase
  }

}

// MARK: - DetailBusinessLogic

extension DetailInteractor: DetailBusinessLogic {

  func fetch() async throws {
    switch await self.articleUseCase.articleByID(self.articleID) {
    case let .success(article):
      self.article = article
      self.article?.comments = await self.commentsUseCase.comments(articleID: self.articleID)
    case let .failure(error):
      throw error
    }
  }
  
}
