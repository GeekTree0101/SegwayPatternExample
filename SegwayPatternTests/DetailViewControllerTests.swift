//
//  DetailViewControllerTests.swift
//  SegwayPatternTests
//
//  Created by Geektree0101 on 2021/11/19.
//

import Foundation
import XCTest
@testable import SegwayPattern

class DetailViewControllerTests: XCTestCase {

  private func createViewController(articleID: Int = -1) -> DetailViewController {
    let viewController = DetailViewController(articleID: articleID)
    // TODO:
    return viewController
  }

  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }

  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

}
