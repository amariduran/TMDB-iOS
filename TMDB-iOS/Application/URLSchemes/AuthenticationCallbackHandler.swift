//
//  AuthenticationCallbackHandler.swift
//  TMDB-iOS
//
//  Created by Amari Duran on 11/1/21.
//

import UIKit

class AuthenticationCallbackHandler: URLSchemeHandler {
	var requestTokenApprovalCallback: ((Bool) -> Void)?
	
	static let shared = AuthenticationCallbackHandler()
	
	private init() { }
	
	var host = "auth"
	
	func handleURL(context: UIOpenURLContext) {
		guard let components = URLComponents(url: context.url, resolvingAgainstBaseURL: false),
						let requestToken = components.queryItems?.first(where: { $0.name == "request_token" })?.value else {
							return
		}
		
		let approved = (components.queryItems?.first(where: { $0.name == "approved" })?.value == "true")
		print("Request token \(requestToken) \(approved ? "was" : "was NOT") approved")
		
		requestTokenApprovalCallback?(approved)
	}
}
