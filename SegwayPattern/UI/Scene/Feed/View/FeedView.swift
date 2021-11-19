//
//  FeedView.swift
//  SegwayPattern
//
//  Created by Geektree0101 on 2021/11/18.
//

import Foundation
import UIKit

import FlexLayout

final class FeedView: UIView {

  let tableView: UITableView = {
    $0.tableFooterView = UIView()
    $0.separatorStyle = .none
    $0.register(FeedCell.self, forCellReuseIdentifier: FeedCell.identifier)
    $0.register(HeaderCell.self, forCellReuseIdentifier: HeaderCell.identifier)
    return $0
  }(UITableView(frame: .zero, style: .plain))

  init() {
    super.init(frame: .zero)
    self.backgroundColor = UIColor.systemBackground
    self.flex.define { root in
      root.addItem(self.tableView).width(100%).height(100%)
    }
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    self.flex.layout()
  }
}
