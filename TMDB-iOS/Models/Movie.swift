//
//  Movie.swift
//  TMDB-iOS
//
//  Created by Cleopatra on 10/9/21.
//

import Foundation

struct Movie: Model, Hashable {
	let id: Int
	let title: String
	let posterPath: String
	let releaseDate: Date
	
	static var releaseDateFormatter: DateFormatter {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "y-MM-dd"
		return dateFormatter
	}
}

extension Movie {
	// The default decoder setting doesn't account for the special date format ("2019-09-01"), and it wouldn't be
	// appropriate to include this in the default decoder implementation, so here we provide a custom decoder just for Movie.
	static var decoder: JSONDecoder {
		let decoder = JSONDecoder()
		decoder.keyDecodingStrategy = .convertFromSnakeCase
		decoder.dateDecodingStrategy = .formatted(Movie.releaseDateFormatter)
		return decoder
	}
}
