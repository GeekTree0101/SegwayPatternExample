//
//  DetailView.swift
//  SegwayPattern
//
//  Created by Geektree0101 on 2021/11/19.
//

import Foundation
import UIKit

import FlexLayout
import Then
import Toast

final class DetailView: UIView {

  let tableView = UITableView(frame: .zero, style: .plain).then {
    $0.tableFooterView = UIView()
    $0.separatorStyle = .none
    $0.register(DetailInfoCell.self, forCellReuseIdentifier: DetailInfoCell.identifier)
    $0.register(DetailCommentHeaderCell.self, forCellReuseIdentifier: DetailCommentHeaderCell.identifier)
    $0.register(DetailCommentCell.self, forCellReuseIdentifier: DetailCommentCell.identifier)
  }

  let contentView = UIView()

  init() {
    super.init(frame: .zero)
    self.backgroundColor = UIColor.systemBackground
    self.flex.define { root in
      root.addItem(self.contentView).define { content in
        content.addItem(self.tableView).width(100%).height(100%)
      }.width(100%).height(100%)
    }
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    self.flex.layout()
  }

  func showErrorToast(error: Error) {
    self.contentView.makeToast(error.localizedDescription)
  }
}
