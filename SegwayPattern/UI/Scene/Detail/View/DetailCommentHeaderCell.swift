//
//  DetailCommentHeaderCell.swift
//  SegwayPattern
//
//  Created by Geektree0101 on 2021/11/21.
//

import Foundation
import UIKit

import FlexLayout
import Then

final class DetailCommentHeaderCell: UITableViewCell {

  static let identifier = "\(type(of: self))"

  private let titleLabel = UILabel().then {
    $0.font = UIFont.boldSystemFont(ofSize: 16.0)
    $0.textColor = UIColor.black
    $0.text = "Comments"
  }

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.contentView.flex.define { root in
      root.addItem(self.titleLabel)
        .marginHorizontal(16.0)
        .marginVertical(24.0)
    }
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    self.contentView.flex.layout(mode: .adjustHeight)
  }

  override func sizeThatFits(_ size: CGSize) -> CGSize {
    self.contentView.bounds.size.width = size.width
    self.contentView.flex.layout(mode: .adjustHeight)
    return self.contentView.frame.size
  }
}
