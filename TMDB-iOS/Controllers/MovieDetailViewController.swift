//
//  MovieDetailViewController.swift
//  TMDB-iOS
//
//  Created by Amari Duran on 10/24/21.
//

import UIKit

class MovieDetailViewController: UIViewController {
	
	var viewModel: MovieViewModel
	
	// MARK: - Init
	
	init(viewModel: MovieViewModel) {
		self.viewModel = viewModel
		
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - View Lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupSubviews()
	}
	
	// MARK: - View Lifecycle Helpers
	
	private func setupSubviews() {
		navigationItem.title = viewModel.movie.title
	}
}
