//
//  RootComponent.swift
//  SegwayPattern
//
//  Created by Geektree0101 on 2021/11/20.
//

import Foundation
import UIKit

import NeedleFoundation

final class RootComponent: BootstrapComponent {

  // MARK: - usecases

  var articlesUseCase: ArticlesUseCase {
    return shared {
      ArticlesUseCase(
        articleRepository: DefaultArticleRepository()
      )
    }
  }

  var articleUseCase: ArticleUseCase {
    return shared {
      ArticleUseCase(
        articleRepository: DefaultArticleRepository()
      )
    }
  }

  var authUserUseCase: AuthUserUseCase {
    return shared {
      AuthUserUseCase(
        userRepository: DefaultUserRepository()
      )
    }
  }

  var commentsUseCase: CommentsUseCase {
    return shared {
      CommentsUseCase(
       commentRepository: DefaultCommentRespository()
     )
    }
  }


  // MARK: - scene

  private var feedBuilder: FeedBuilder {
    return FeedComponent(parent: self)
  }

  // MARK: - root

  func rootViewController() -> UIViewController {
    return self.feedBuilder.feedViewController()
  }
}
