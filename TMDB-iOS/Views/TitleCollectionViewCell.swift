//
//  TitleCollectionViewCell.swift
//  TMDB-iOS
//
//  Created by Cleopatra on 10/21/21.
//

import UIKit

class TitleCollectionViewCell: UICollectionViewCell {
	static let identifier = String(describing: self)
	
	let titleLabel = UILabel()
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		titleLabel.textColor = .label
		titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
		
		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		contentView.addSubview(titleLabel)
		
		titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
		titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
	}
	
	func set(title: String) {
		self.titleLabel.text = title
	}
	
	func isShowAllHidden(value: Bool) {
		
	}
}

