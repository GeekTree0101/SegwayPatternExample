//
//  Article.swift
//  SegwayPattern
//
//  Created by Geektree0101 on 2021/11/18.
//

import Foundation

struct Article {
  let id: Int
  let title: String
  let content: String
  let user: User?
  var comments: [Comment]
}
