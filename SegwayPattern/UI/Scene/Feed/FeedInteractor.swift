//
//  FeedInteractor.swift
//  SegwayPattern
//
//  Created by Geektree0101 on 2021/11/18.
//

import Foundation

protocol FeedDataStore: AnyObject {

  var authUser: User? { get }
  var articles: [Article] { get }
}

protocol FeedBusinessLogic {

  func fetch() async throws
}

final class FeedInteractor: FeedDataStore {

  // MARK: - datastore

  var authUser: User?
  var articles: [Article] = []

  // MARK: - dependencies

  private let articlesUseCase: ArticlesUseCase
  private let authUserUseCase: AuthUserUseCase

  init(articlesUseCase: ArticlesUseCase,
       authUserUseCase: AuthUserUseCase) {
    self.articlesUseCase = articlesUseCase
    self.authUserUseCase = authUserUseCase
  }

}

// MARK: - FeedBusinessLogic

extension FeedInteractor: FeedBusinessLogic {

  func fetch() async throws {
    self.authUser = await self.authUserUseCase.me()
    self.articles = await self.articlesUseCase.articles()
  }
}
