//
//  ArticlesUseCase.swift
//  SegwayPattern
//
//  Created by Geektree0101 on 2021/11/18.
//

import Foundation

final class ArticlesUseCase {

  private let articleRepository: ArticleRepository

  init(articleRepository: ArticleRepository) {
    self.articleRepository = articleRepository
  }

  func articles() async -> [Article] {
    return await self.articleRepository.articles()
  }
}
