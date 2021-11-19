//
//  CommentsUseCase.swift
//  SegwayPattern
//
//  Created by Geektree0101 on 2021/11/19.
//

import Foundation

final class CommentsUseCase {

  private let commentRepository: CommentRespository

  init(commentRepository: CommentRespository) {
    self.commentRepository = commentRepository
  }

  func comments(articleID: Int) async -> [Comment] {
    return await self.commentRepository.comments(articleID: articleID)
  }
}
