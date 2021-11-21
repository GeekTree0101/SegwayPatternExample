//
//  DetailComponent.swift
//  SegwayPattern
//
//  Created by Geektree0101 on 2021/11/20.
//

import Foundation
import UIKit

import NeedleFoundation

protocol DetailDependency: Dependency {

  var articleUseCase: ArticleUseCase { get }
  var commentsUseCase: CommentsUseCase { get }
}

protocol DetailBuilder {

  func detailViewController(articleID: Int) -> DetailViewController
}

final class DetailComponent: Component<DetailDependency>, DetailBuilder {

  func detailViewController(articleID: Int) -> DetailViewController {
    let interactor = DetailInteractor(
      articleID: articleID,
      articleUseCase: self.articleUseCase,
      commentsUseCase: self.commentsUseCase
    )

    let presenter = DetailPresenter()

    let viewController = DetailViewController(
      interactor: interactor,
      presenter: presenter
    )

    presenter.dataStore = interactor
    presenter.viewController = viewController
    return viewController
  }
}
