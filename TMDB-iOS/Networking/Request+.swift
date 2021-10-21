//
//  Request+.swift
//  TMDB-iOS
//
//  Created by Cleopatra on 10/9/21.
//

import Foundation
import SimpleNetworking

extension Request {
	static func popularMovies(_ completion: @escaping (Result<PagedResults<Movie>, APIError>) -> Void) -> Request {
		Request.basic(
			baseURL: TMDBMovie.baseURL,
			path: "discover/movie",
			params: [
				URLQueryItem(name: "sort_by", value: "popularity.desc")
			]
		) { result in
			result.decoding(PagedResults<Movie>.self, completion: completion)
		}
	}
}

extension Request {
	static func createRequestToken(_ completion: @escaping (Result<AuthenticationTokenResponse, APIError>) -> Void) -> Request {
		Request.basic(
			baseURL: TMDBMovie.baseURL,
			path: "authentication/token/new"
		) { result in
			result.decoding(AuthenticationTokenResponse.self, completion: completion)
		}
	}
}
