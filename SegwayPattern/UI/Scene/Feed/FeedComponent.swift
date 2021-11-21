//
//  FeedComponent.swift
//  SegwayPattern
//
//  Created by Geektree0101 on 2021/11/20.
//

import Foundation
import UIKit

import NeedleFoundation

protocol FeedDependency: Dependency {

  var articlesUseCase: ArticlesUseCase { get }
  var authUserUseCase: AuthUserUseCase { get }
}

protocol FeedBuilder {

  func feedViewController() -> FeedViewController
}

final class FeedComponent: Component<FeedDependency>, FeedBuilder {

  var detailBuilder: DetailBuilder {
    return DetailComponent(parent: self)
  }

  func feedViewController() -> FeedViewController {
    let interactor = FeedInteractor(
      articlesUseCase: self.articlesUseCase,
      authUserUseCase: self.authUserUseCase
    )

    let presenter = FeedPresenter(
      detailBuilder: self.detailBuilder
    )

    let viewController = FeedViewController(
      interactor: interactor,
      presenter: presenter
    )

    presenter.dataStore = interactor
    presenter.viewController = viewController

    return viewController
  }
}
