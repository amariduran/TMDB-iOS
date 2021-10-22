//
//  TitleSupplementaryView.swift
//  TMDB-iOS
//
//  Created by Cleopatra on 10/21/21.
//

import UIKit

class TitleSupplementaryView: UICollectionReusableView {
	static let reuseIdentifier = "title-supplementary-reuse-identifier"
	
	let label = UILabel()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		setupSubviews()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupSubviews() {
		label.font = .preferredFont(forTextStyle: .title3)
		label.adjustsFontForContentSizeCategory = true
		label.translatesAutoresizingMaskIntoConstraints = false
		
		addSubview(label)
		
		NSLayoutConstraint.activate([
			label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
			label.topAnchor.constraint(equalTo: topAnchor, constant: 8),
			label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
			label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
		])
	}
}
