//
//  XCTestCase+Extension.swift
//  SegwayPatternTests
//
//  Created by Geektree0101 on 2021/11/21.
//

import Foundation
import XCTest

extension XCTestCase {

  @MainActor
  func MainActorTaskBlock(_ executeHandler: @escaping () -> Void) async {
    _ = await Task {
      executeHandler()
    }.result
  }
  
}
