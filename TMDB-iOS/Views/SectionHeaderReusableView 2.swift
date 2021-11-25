//
//  SectionHeaderReusableView.swift
//  TMDB-iOS
//
//  Created by Amari Duran on 10/21/21.
//

import UIKit

class SectionHeaderReusableView: UICollectionReusableView {
//	static let reuseIdentifier = String(describing: self)
	
	let titleLabel: UILabel = {
		let label = UILabel()
		label.font = .preferredFont(forTextStyle: .headline)
		label.textColor = .label
		label.adjustsFontForContentSizeCategory = true
		label.numberOfLines = 1
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		setupSubviews()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupSubviews() {
		addSubview(titleLabel)
		
		NSLayoutConstraint.activate([
			titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
			titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 4),
			titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
			titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4)
		])
	}
	
}
