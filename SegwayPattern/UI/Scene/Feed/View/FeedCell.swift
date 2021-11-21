//
//  FeedCell.swift
//  SegwayPattern
//
//  Created by Geektree0101 on 2021/11/18.
//

import Foundation
import UIKit

import FlexLayout
import Then

final class FeedCell: UITableViewCell {

  struct ViewModel {
    let title: String
    let desc: String
    let author: String
  }

  static let identifier = "\(type(of: self))"

  private let titleLabel = UILabel().then {
    $0.font = UIFont.boldSystemFont(ofSize: 24.0)
  }

  private let descLabel = UILabel().then {
    $0.font = UIFont.systemFont(ofSize: 16.0)
    $0.textColor = UIColor.gray
  }

  private let authorLabel = UILabel().then {
    $0.font = UIFont.systemFont(ofSize: 14.0)
    $0.textColor = UIColor.lightGray
  }

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.contentView.flex.define { root in
      root
        .addItem()
        .direction(.column)
        .define { col in
          col.addItem(self.titleLabel)
          col.addItem().height(16.0)
          col.addItem(self.descLabel)
          col.addItem().height(8.0)
          col.addItem(self.authorLabel)
        }
        .padding(16.0)
    }
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    self.titleLabel.text = nil
    self.descLabel.text = nil
    self.authorLabel.text = nil
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    self.contentView.flex.layout(mode: .adjustHeight)
  }

  func configure(viewModel: ViewModel) {
    self.titleLabel.text = viewModel.title
    self.descLabel.text = viewModel.desc
    self.authorLabel.text = viewModel.author
    self.titleLabel.flex.markDirty()
    self.descLabel.flex.markDirty()
    self.authorLabel.flex.markDirty()
    self.setNeedsLayout()
  }

  override func sizeThatFits(_ size: CGSize) -> CGSize {
    self.contentView.bounds.size.width = size.width
    self.contentView.flex.layout(mode: .adjustHeight)
    return self.contentView.frame.size
  }
}
