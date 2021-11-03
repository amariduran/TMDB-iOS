//
//  FavoritesViewController.swift
//  TMDB-iOS
//
//  Created by Amari Duran on 10/27/21.
//

import UIKit

class FavoritesViewController: UIViewController {

	var sessionManager: SessionManager
	
	// MARK: - Initialization
	
	init(sessionManager: SessionManager) {
		self.sessionManager = sessionManager
		
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - View Lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()

		tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
				
		setupSubviews()
	}
	
	private func setupSubviews() {
		if !sessionManager.isLoggedIn {
			let backgroundMessageView = BackgroundMessageView(title: "In order to manage \"Favorites\"", buttonTitle: "Log In")
			backgroundMessageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
			backgroundMessageView.frame = view.bounds
			backgroundMessageView.onButtonTapped = {
				self.loginTapped()
			}
			
			view.addSubview(backgroundMessageView)
		}
	}
	
	@objc private func loginTapped() {
		sessionManager.startLogin(from: self)
	}
	
}
