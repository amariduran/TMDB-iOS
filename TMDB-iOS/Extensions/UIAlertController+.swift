//
//  UIAlertController+.swift
//  TMDB-iOS
//
//  Created by Amari Duran on 10/24/21.
//

import UIKit

extension UIAlertController {
	static func presentAlert(title: String? = nil, message: String, from viewController: UIViewController) {
		let alertController = UIAlertController(title: title,
																						message: message,
																						preferredStyle: .alert)
		
		let okayAction = UIAlertAction(title: "Okay", style: .default) { action in
			viewController.dismiss(animated: true)
		}
		
		alertController.addAction(okayAction)
		viewController.present(alertController, animated: true)
	}
}
