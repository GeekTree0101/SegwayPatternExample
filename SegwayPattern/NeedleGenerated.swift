

import Foundation
import NeedleFoundation
import UIKit

// swiftlint:disable unused_declaration
private let needleDependenciesHash : String? = nil

// MARK: - Registration

public func registerProviderFactories() {
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: "^->RootComponent->FeedComponent->DetailComponent") { component in
        return DetailDependencya00aa1c88f19925f559dProvider(component: component)
    }
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: "^->RootComponent->FeedComponent") { component in
        return FeedDependencydb8fd4a3ca682ca00545Provider(component: component)
    }
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: "^->RootComponent") { component in
        return EmptyDependencyProvider(component: component)
    }
    
}

// MARK: - Providers

private class DetailDependencya00aa1c88f19925f559dBaseProvider: DetailDependency {
    var articleUseCase: ArticleUseCase {
        return rootComponent.articleUseCase
    }
    var commentsUseCase: CommentsUseCase {
        return rootComponent.commentsUseCase
    }
    private let rootComponent: RootComponent
    init(rootComponent: RootComponent) {
        self.rootComponent = rootComponent
    }
}
/// ^->RootComponent->FeedComponent->DetailComponent
private class DetailDependencya00aa1c88f19925f559dProvider: DetailDependencya00aa1c88f19925f559dBaseProvider {
    init(component: NeedleFoundation.Scope) {
        super.init(rootComponent: component.parent.parent as! RootComponent)
    }
}
private class FeedDependencydb8fd4a3ca682ca00545BaseProvider: FeedDependency {
    var articlesUseCase: ArticlesUseCase {
        return rootComponent.articlesUseCase
    }
    var authUserUseCase: AuthUserUseCase {
        return rootComponent.authUserUseCase
    }
    private let rootComponent: RootComponent
    init(rootComponent: RootComponent) {
        self.rootComponent = rootComponent
    }
}
/// ^->RootComponent->FeedComponent
private class FeedDependencydb8fd4a3ca682ca00545Provider: FeedDependencydb8fd4a3ca682ca00545BaseProvider {
    init(component: NeedleFoundation.Scope) {
        super.init(rootComponent: component.parent as! RootComponent)
    }
}
