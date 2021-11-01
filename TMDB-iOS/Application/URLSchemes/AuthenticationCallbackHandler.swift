//
//  AuthenticationCallbackHandler.swift
//  TMDB-iOS
//
//  Created by Amari Duran on 11/1/21.
//

import Foundation

class AuthenticationCallbackHandler: URLSchemeHandler {
	var requestTokenApprovalCallback: ((Bool) -> Void)?
	
	static let shared = AuthenticationCallbackHandler()
	
	private init() { }
	
	// URLSchemeHandler
	
	var host = "auth"
	
	func handleURL(context: UIOpenURLContext) {
		guard let components = URLComponents(url: context.url, resolvingAgainstBaseURL: false) else { return }
		guard let requestToken = components.queryItems?.first(where: { $0.name == "request_token" })?.value else { return }
		let approved = (components.queryItems?.first(where: { $0.name == "approved" })?.value == "true")
		
		print("Request token \(requestToken) \(approved ? "was" : "was NOT") approved \(approved ? "✅" : "❌")")
		
		requestTokenApprovalCallback?(approved)
	}
}
