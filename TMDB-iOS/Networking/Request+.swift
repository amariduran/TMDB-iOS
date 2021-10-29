//
//  Request+.swift
//  TMDB-iOS
//
//  Created by Amari Duran on 10/9/21.
//

import Foundation
import SimpleNetworking

extension Request {
	
	static func popular(_ completion: @escaping (Result<PagedResults<Movie>, APIError>) -> Void) -> Request {
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
