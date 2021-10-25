//
//  Request+.swift
//  TMDB-iOS
//
//  Created by Amari Duran on 10/9/21.
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
	
	static func nowPlaying(_ completion: @escaping (Result<PagedResults<Movie>, APIError>) -> Void) -> Request {
		Request.basic(
			baseURL: TMDBMovie.baseURL,
			path: ""
		) { result in
			result.decoding(PagedResults<Movie>.self, completion: completion)
		}
	}
	
	static func upcoming(_ completion: @escaping (Result<PagedResults<Movie>, APIError>) -> Void) -> Request {
		Request.basic(
			baseURL: TMDBMovie.baseURL,
			path: ""
		) { result in
			result.decoding(PagedResults<Movie>.self, completion: completion)
		}
	}
}
