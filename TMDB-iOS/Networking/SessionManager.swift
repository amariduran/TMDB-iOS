//
//  SessionManager.swift
//  TMDB-iOS
//
//  Created by Amari Duran on 10/29/21.
//

import SafariServices

class SessionManager {
	
	var currentSessionId: String? {
		didSet {
			print("SessionID: \(currentSessionId)")
		}
	}
	
	var isLoggedIn: Bool {
		return currentSessionId != nil
	}
	
	func startLogin(from viewController: UIViewController) {
		TMDBMovie.api.send(request: .requestToken { result in
			switch result {
			case .success(let response):
				self.authorizeRequestToken(response.requestToken, from: viewController)
				
			case .failure(let error):
				print("Error fetching request token: ", error.localizedDescription)
			}
		})
	}
	
	// Once the user has approved your request token, they will either be redirected to the URL you specified in the
	// redirect_to parameter or to the /authenticate/allow/ path on TMDB. If they aren't redirected to a custom
	// URL, the page will also have a Authentication-Callback header. This header contains the API call to create
	// a session ID. You can either manually generate it or simply use the one we return.
	private func authorizeRequestToken(_ requestToken: String?, from viewController: UIViewController) {
		guard let requestToken = requestToken,
					let url = URL(string: "https://www.themoviedb.org/authenticate/\(requestToken)?redirect_to=tmdb-ios://auth") else {
			return
		}
		
		let safariViewController = SFSafariViewController(url: url)
		viewController.present(safariViewController, animated: true, completion: nil)

		AuthenticationCallbackHandler.shared.requestTokenApprovalCallback = { approved in
			viewController.dismiss(animated: true) {
				if approved {
					self.startSession(requestToken: requestToken) { _ in
						
					}
				} else {
					print("Request denied. You must approve the login request to log in.")
				}
			}
		}
	}
	
	private func startSession(requestToken: String, completion: @escaping (Bool) -> Void) {
		TMDBMovie.api.send(request: .createSession(
			requestToken: requestToken
		) { result in
			switch result {
			case .success(let response):
				if response.success {
					self.currentSessionId = response.sessionId
				}
				
				completion(response.success)
				
			case .failure(let error):
				print("Error: ", error)
				completion(false)
			}
		})
	}
	
}
