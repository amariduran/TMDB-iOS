//
//  Request+.swift
//  TMDB-iOS
//
//  Created by Amari Duran on 10/9/21.
//

import Foundation
import SimpleNetworking

extension Request {

	static func nowPlaying(_ completion: @escaping (Result<PagedResults<Movie>, APIError>) -> Void) -> Request {
		Request.basic(
			baseURL: TMDBMovie.baseURL,
			path: "/movie/now_playing",
			params: [
				URLQueryItem(name: "language", value: "en-US")
			]
		) { result in
			result.decoding(PagedResults<Movie>.self, completion: completion)
		}
	}
	
	static func topRated(_ completion: @escaping (Result<PagedResults<Movie>, APIError>) -> Void) -> Request {
		Request.basic(
			baseURL: TMDBMovie.baseURL,
			path: "/movie/top_rated",
			params: [
				URLQueryItem(name: "language", value: "en-US")
			]
		) { result in
			result.decoding(PagedResults<Movie>.self, completion: completion)
		}
	}
	
	static func upcoming(_ completion: @escaping (Result<PagedResults<Movie>, APIError>) -> Void) -> Request {
		Request.basic(
			baseURL: TMDBMovie.baseURL,
			path: "/movie/upcoming",
			params: [
				URLQueryItem(name: "language", value: "en-US")
			]
		) { result in
			result.decoding(PagedResults<Movie>.self, completion: completion)
		}
	}
	
}

extension Request {
	
	// Create a temporary request token that can be used to validate a TMDB user login.
	// The token expires after 60 minutes if not used.
	static func requestToken(_ completion: @escaping (Result<AuthenticationTokenResponse, APIError>) -> Void) -> Request {
		Request.basic(
			baseURL: TMDBMovie.baseURL,
			path: "/authentication/token/new"
		) { result in
			result.decoding(AuthenticationTokenResponse.self, completion: completion)
		}
	}
	
	// By calling the new session method with the request token that has been approved by the user, we will
	// return a new session_id. This is the session that can now be used to write user data. Treat this key like a
	// password and keep it secret.
	static func createSession(requestToken: String,
														_ completion: @escaping (Result<CreateSessionResponse, APIError>) -> Void) -> Request {
		let request = Request.post(
			baseURL: TMDBMovie.baseURL,
			path: "authentication/session/new",
			body: CreateSessionRequest(requestToken: requestToken)
		) { result in
			result.decoding(CreateSessionResponse.self, completion: completion)
		}
		
		return request
	}
	
}
