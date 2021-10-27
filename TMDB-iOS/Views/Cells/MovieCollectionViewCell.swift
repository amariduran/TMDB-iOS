//
//  MovieCollectionViewCell.swift
//  TMDB-iOS
//
//  Created by Amari Duran on 10/21/21.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
//	static let reuseIdentifier = String(describing: self)
	
	var viewModel: MovieViewModel? {
		didSet {
			imageView.image = viewModel?.posterImage
		}
	}
	
	private var imageView = UIImageView()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		
		imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		contentView.addSubview(imageView)
		
		imageView.frame = contentView.bounds
		
		contentView.layer.cornerRadius = 4
		contentView.layer.masksToBounds = true
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
		
		imageView.image = nil
	}
}
