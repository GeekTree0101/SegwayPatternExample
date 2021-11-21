//
//  HeaderCell.swift
//  SegwayPattern
//
//  Created by Geektree0101 on 2021/11/19.
//

import Foundation
import UIKit

import FlexLayout
import Then

final class HeaderCell: UITableViewCell {

  struct ViewModel {
    let welcomeMessage: String
  }

  static let identifier = "\(type(of: self))"

  private let titleLabel = UILabel().then {
    $0.font = UIFont.boldSystemFont(ofSize: 32.0)
    $0.numberOfLines = 0
  }

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.contentView.flex.define { root in
      root
        .addItem(self.titleLabel)
        .marginHorizontal(16.0)
        .marginVertical(60.0)
    }
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    self.titleLabel.text = nil
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    self.contentView.flex.layout(mode: .adjustHeight)
  }

  func configure(viewModel: ViewModel) {
    self.titleLabel.text = viewModel.welcomeMessage
    self.titleLabel.flex.markDirty()
    self.setNeedsLayout()
  }
}
