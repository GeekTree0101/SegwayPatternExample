//
//  DetailCommentCell.swift
//  SegwayPattern
//
//  Created by Geektree0101 on 2021/11/19.
//

import Foundation
import UIKit

import FlexLayout
import Then

final class DetailCommentCell: UITableViewCell {
  
  static let identifier = "\(type(of: self))"

  struct ViewModel {
    let author: String
    let content: String
  }

  private let thumbnailImageView = UIImageView().then {
    $0.backgroundColor = UIColor.lightGray
    $0.clipsToBounds = true
  }

  private let contentLabel = UILabel().then {
    $0.font = UIFont.systemFont(ofSize: 16.0)
    $0.textColor = UIColor.black
    $0.textAlignment = .center
  }

  private let authorLabel = UILabel().then {
    $0.font = UIFont.boldSystemFont(ofSize: 14.0)
    $0.textColor = UIColor.black
    $0.textAlignment = .center
  }

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.contentView.flex.define { root in

      root.addItem()
        .direction(.row)
        .alignItems(.center)
        .justifyContent(.start)
        .margin(12.0)
        .define { row in
          row.addItem(self.thumbnailImageView).size(48.0).backgroundColor(.gray).define {
            $0.view?.layer.cornerRadius = 24.0
          }
          row.addItem().width(12.0)
          row
            .addItem()
            .direction(.column)
            .alignItems(.start)
            .define { col in
              col.addItem(self.authorLabel)
              col.addItem().height(8.0)
              col.addItem(self.contentLabel)
            }
        }
    }
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    self.thumbnailImageView.image = nil
    self.contentLabel.text = nil
    self.authorLabel.text = nil
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    self.contentView.flex.layout(mode: .adjustHeight)
  }

  func configure(viewModel: ViewModel) {
    self.thumbnailImageView.image = UIImage(named: "david")
    self.contentLabel.text = viewModel.content
    self.authorLabel.text = viewModel.author
  }

  override func sizeThatFits(_ size: CGSize) -> CGSize {
    self.contentView.bounds.size.width = size.width
    self.contentView.flex.layout(mode: .adjustHeight)
    return self.contentView.frame.size
  }
}
