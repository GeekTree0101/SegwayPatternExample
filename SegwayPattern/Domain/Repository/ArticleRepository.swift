//
//  ArticleRepository.swift
//  SegwayPattern
//
//  Created by Geektree0101 on 2021/11/18.
//

import Foundation

protocol ArticleRepository {

  func articles() async -> [Article]
  func articleByID(_ id: Int) async -> Result<Article, Error>
}

final class DefaultArticleRepository: ArticleRepository {

  func articles() async -> [Article] {
    return self.dummyArticles
  }

  func articleByID(_ id: Int) async -> Result<Article, Error> {
    guard let article = self.dummyArticles.first(where: { $0.id == id }) else {
      return .failure(NSError(domain: "not found", code: 404, userInfo: nil))
    }
    return .success(article)
  }

  private let dummyArticles = [
    Article(
      id: 1,
      title: "Welcome to karrot",
      content: "karrot ios team workshop",
      user: User(
        id: 1,
        name: "david"
      ),
      comments: [
        Comment(id: 1, user: User(id: 1, name: "david"), content: "holalalalal1"),
        Comment(id: 2, user: User(id: 1, name: "david"), content: "holalalalal2"),
        Comment(id: 3, user: User(id: 1, name: "david"), content: "holalalalal3"),
        Comment(id: 4, user: User(id: 1, name: "david"), content: "holalalalal4"),
        Comment(id: 5, user: User(id: 1, name: "david"), content: "holalalalal5"),
        Comment(id: 6, user: User(id: 1, name: "david"), content: "holalalalal6")
      ]
    ),
    Article(
      id: 2,
      title: "This is segway pattern",
      content: "is it clean? no",
      user: User(
        id: 2,
        name: "marty"
      ),
      comments: [
        Comment(id: 1, user: User(id: 1, name: "david"), content: "holalalalal1"),
        Comment(id: 2, user: User(id: 1, name: "david"), content: "holalalalal2"),
        Comment(id: 3, user: User(id: 1, name: "david"), content: "holalalalal3"),
        Comment(id: 4, user: User(id: 1, name: "david"), content: "holalalalal4"),
        Comment(id: 5, user: User(id: 1, name: "david"), content: "holalalalal5"),
        Comment(id: 6, user: User(id: 1, name: "david"), content: "holalalalal6")
      ]
    ),
    Article(
      id: 3,
      title: "Declarative orchestration",
      content: "Segway pattern aim for declarative orchestration",
      user: User(
        id: 3,
        name: "ray"
      ),
      comments: [
        Comment(id: 1, user: User(id: 1, name: "david"), content: "holalalalal1"),
        Comment(id: 2, user: User(id: 1, name: "david"), content: "holalalalal2"),
        Comment(id: 3, user: User(id: 1, name: "david"), content: "holalalalal3"),
        Comment(id: 4, user: User(id: 1, name: "david"), content: "holalalalal4"),
        Comment(id: 5, user: User(id: 1, name: "david"), content: "holalalalal5"),
        Comment(id: 6, user: User(id: 1, name: "david"), content: "holalalalal6")
      ]
    ),
    Article(
      id: 4,
      title: "Immersive Development",
      content: "Seamless cooperation with colleagues",
      user: User(
        id: 4,
        name: "daniel"
      ),
      comments: [
        Comment(id: 1, user: User(id: 1, name: "david"), content: "holalalalal1"),
        Comment(id: 2, user: User(id: 1, name: "david"), content: "holalalalal2"),
        Comment(id: 3, user: User(id: 1, name: "david"), content: "holalalalal3"),
        Comment(id: 4, user: User(id: 1, name: "david"), content: "holalalalal4"),
        Comment(id: 5, user: User(id: 1, name: "david"), content: "holalalalal5"),
        Comment(id: 6, user: User(id: 1, name: "david"), content: "holalalalal6")
      ]
    ),
    Article(
      id: 4,
      title: "david...",
      content: "David, I don't think it's a little bit suxx.",
      user: User(
        id: 5,
        name: "ryan"
      ),
      comments: [
        Comment(id: 1, user: User(id: 1, name: "david"), content: "holalalalal1"),
        Comment(id: 2, user: User(id: 1, name: "david"), content: "holalalalal2"),
        Comment(id: 3, user: User(id: 1, name: "david"), content: "holalalalal3"),
        Comment(id: 4, user: User(id: 1, name: "david"), content: "holalalalal4"),
        Comment(id: 5, user: User(id: 1, name: "david"), content: "holalalalal5"),
        Comment(id: 6, user: User(id: 1, name: "david"), content: "holalalalal6")
      ]
    ),
    Article(
      id: 5,
      title: "wowwow",
      content: "very good",
      user: User(
        id: 6,
        name: "lychee"
      ),
      comments: [
        Comment(id: 1, user: User(id: 1, name: "david"), content: "holalalalal1"),
        Comment(id: 2, user: User(id: 1, name: "david"), content: "holalalalal2"),
        Comment(id: 3, user: User(id: 1, name: "david"), content: "holalalalal3"),
        Comment(id: 4, user: User(id: 1, name: "david"), content: "holalalalal4"),
        Comment(id: 5, user: User(id: 1, name: "david"), content: "holalalalal5"),
        Comment(id: 6, user: User(id: 1, name: "david"), content: "holalalalal6")
      ]
    )
  ]
}
