//
//  CommentRespository.swift
//  SegwayPattern
//
//  Created by Geektree0101 on 2021/11/19.
//

import Foundation

protocol CommentRespository {

  func comments(articleID: Int) async -> [Comment]
}

final class DefaultCommentRespository: CommentRespository {

  func comments(articleID: Int) async -> [Comment] {
    return [
      Comment(id: 1, user: User(id: 1, name: "david"), content: "holalalalal1"),
      Comment(id: 2, user: User(id: 1, name: "david"), content: "holalalalal2"),
      Comment(id: 3, user: User(id: 1, name: "david"), content: "holalalalal3"),
      Comment(id: 4, user: User(id: 1, name: "david"), content: "holalalalal4"),
      Comment(id: 5, user: User(id: 1, name: "david"), content: "holalalalal5"),
      Comment(id: 6, user: User(id: 1, name: "david"), content: "holalalalal6")
    ]
  }

}
