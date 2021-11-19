//
//  ArticleUseCase.swift
//  SegwayPattern
//
//  Created by Geektree0101 on 2021/11/18.
//

import Foundation

final class ArticleUseCase {

  private let articleRepository: ArticleRepository

  init(articleRepository: ArticleRepository) {
    self.articleRepository = articleRepository
  }

  func articleByID(_ id: Int) async -> Result<Article, Error> {
    return await self.articleRepository.articleByID(id)
  }
}
