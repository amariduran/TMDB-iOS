//
//  AuthenticationTokenResponse.swift
//  TMDB-iOS
//
//  Created by Cleopatra on 10/14/21.
//

import Foundation

/*
 To make authenticated requests as a user, TMDB uses an asynchronous session approval flow using a web browser and a
 redirect to a URL scheme that our app handles.

 The first step in this process is to request a new authentication token.
 */
struct AuthenticationTokenResponse: Model {
	let success: Bool
	let expiresAt: Date
	let requestToken: String
}

/*
 This response uses ISO 8601 Date formats, so we'll have to override the decoder to provide our own that can handle
 this format.
 */
extension AuthenticationTokenResponse {
	static var decoder: JSONDecoder {
		let decoder = JSONDecoder()
		
		// 2019-11-10 19:02:22 UTC
		// If you're not very familiar with these date formats, take a loook at https://nsdateformatter.com which is an interactive date formatting reference site.
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
		
		decoder.dateDecodingStrategy = .formatted(dateFormatter)
		decoder.keyDecodingStrategy = .convertFromSnakeCase
		
		return decoder
	}
}
