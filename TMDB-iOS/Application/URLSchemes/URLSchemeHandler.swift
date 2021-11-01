//
//  URLSchemeHandler.swift
//  TMDB-iOS
//
//  Created by Amari Duran on 11/1/21.
//

import UIKit

protocol URLSchemeHandler {
	var host: String { get }
	func handleURL(context: UIOpenURLContext)
}

struct URLSchemeHandlers {
	static var registered: [URLSchemeHandler] {
		return [AuthenticationCallbackHandler.shared]
	}
}
