//
//  DetailPresenter.swift
//  SegwayPattern
//
//  Created by Geektree0101 on 2021/11/18.
//

import Foundation

protocol DetailPresenterLogic: AnyObject {

  var info: DetailInfoCell.ViewModel? { get }
  var comments: [DetailCommentCell.ViewModel] { get }
  func makeContent()
}

final class DetailPresenter: DetailPresenterLogic {

  var info: DetailInfoCell.ViewModel?
  var comments: [DetailCommentCell.ViewModel] = []

  weak var dataStore: DetailDataStore!
  weak var viewController: DetailViewController?

  func makeContent() {
    self.info = DetailInfoCell.ViewModel(
      title: "❤️\n\(self.dataStore.article?.title ?? "")",
      desc: self.dataStore.article?.content ?? "",
      author: "Created by \(self.dataStore.article?.user?.name ?? "")"
    )
    self.comments = self.dataStore.article?.comments.map { comment in
      return DetailCommentCell.ViewModel(
        author: comment.user?.name ?? "???",
        content: comment.content
      )
    } ?? []
  }
}
