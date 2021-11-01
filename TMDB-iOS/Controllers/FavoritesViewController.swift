//
//  FavoritesViewController.swift
//  TMDB-iOS
//
//  Created by Amari Duran on 10/27/21.
//

import UIKit

class FavoritesViewController: UIViewController {
	
	let sessionManager = SessionManager()
	
	override func viewDidLoad() {
		super.viewDidLoad()

		
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)

		sessionManager.startLogin(from: self)
	}
	
	
}
