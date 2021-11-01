//
//  SessionManager.swift
//  TMDB-iOS
//
//  Created by Amari Duran on 10/29/21.
//

import SafariServices

class SessionManager {
	
	var sessionId: String?
	
	var isLoggedIn: Bool {
		return sessionId != nil
	}
	
	func startLogin(from viewController: UIViewController) {
		TMDBMovie.api.send(.requestToken { result in
			switch result {
			case .success(let response):
				self.authorizeRequestToken(response.requestToken, from: viewController)
				
			case .failure(let error):
				let alertController = UIAlertController(title: "Error fetching request token.",
																								message: error.localizedDescription,
																								preferredStyle: .alert)
				alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
				viewController.present(alertController, animated: true, completion: nil)
			}
		})
	}
	
	// Once the user has approved your request token, they will either be redirected to the URL you specified in the
	// redirect_to parameter or to the /authenticate/allow/ path on TMDB. If they aren't redirected to a custom
	// URL, the page will also have a Authentication-Callback header. This header contains the API call to create
	// a session ID. You can either manually generate it or simply use the one we return.
	private func authorizeRequestToken(_ requestToken: String?, from viewController: UIViewController) {
		guard let requestToken = requestToken else { return }
		guard let url = URL(string: "https://www.themoviedb.org/authenticate/\(requestToken)?redirect_to=tmdb-ios://auth") else { return }
		
		let safariVC = SFSafariViewController(url: url)
		viewController.present(safariVC, animated: true, completion: nil)

		AuthenticationCallbackHandler.shared.requestTokenApprovalCallback = { approved in
			viewController.dismiss(animated: true) {
				if approved {
					
				} else {
					let alertController = UIAlertController(title: "Request denied",
																									message: "You must approve the login request to log in.",
																									preferredStyle: .alert)
					alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
					viewController.present(alertController, animated: true, completion: nil)
				}
			}
		}
	}
	
	private func startSession(requestToken: String, completion: @escaping (Bool) -> Void) {
		TMDBMovie.api.send(.createSession(
			requestToken: requestToken
		) { result in
			switch result {
			case .success(let response):
				self.sessionId = response.sessionId
				
			case .failure(let error):
				print(error.localizedDescription)
				completion(false)
			}
		})
	}
	
//	private func startSession(requestToken: String, completion: @escaping (Bool) -> Void) {
//			MovieDB.api.send(request: .createSession(requestToken: requestToken) { result in
//					switch result {
//					case .success(let response):
//							if response.success {
//									self.currentSessionId = response.sessionId
//									Current.accountManager.fetchAccount { result in
//											switch result {
//											case .success(let account):
//													self.currentAccountId = account.id
//													NotificationCenter.default.post(name: SessionManager.currentUserDidChange, object: self)
//											case .failure(let error):
//													print("Error fetching account", error)
//											}
//									}
//							}
//							completion(response.success)
//
//					case .failure(let error):
//							print("Error: ", error)
//							completion(false)
//					}
//			})
//	}
	
}
