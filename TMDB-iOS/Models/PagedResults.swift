//
//  PagedResults.swift
//  TMDB-iOS
//
//  Created by Amari Duran on 10/9/21.
//

import Foundation
import SimpleNetworking

/*
 Generic type PagedResults with a generic parameter T. T is constrained to be an implementation of Model,
 so we know it is decoable already.
 */
struct PagedResults<T: Model>: Model {
	let page: Int?
	let results: [T]?
	let dates: MovieDate?
	let totalPages: Int?
	let totalResults: Int?
}

extension PagedResults {
	// The trick here is that we somehow need this PagedResults to be decoded with the right decoder, since it may have
	// special requirements for dates, and so on. As it turns out we can just use T's decoder.
	static var decoder: JSONDecoder { T.decoder }
}
