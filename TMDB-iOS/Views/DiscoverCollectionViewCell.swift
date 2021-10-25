//
//  DiscoverCollectionViewCell.swift
//  TMDB-iOS
//
//  Created by Amari Duran on 10/21/21.
//

import UIKit

class DiscoverCollectionViewCell: UICollectionViewCell {
	static let identifier = String(describing: self)
	
	var imageView = UIImageView()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		
		imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		contentView.addSubview(imageView)
		
		imageView.frame = contentView.bounds
		
		contentView.layer.cornerRadius = 4
		contentView.layer.backgroundColor = UIColor.systemCyan.cgColor
		contentView.layer.masksToBounds = true
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
