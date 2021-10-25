//
//  Movie.swift
//  TMDB-iOS
//
//  Created by Amari Duran on 10/9/21.
//

import Foundation
import UIKit

class MovieViewModel: Hashable {
	
	static func == (lhs: MovieViewModel, rhs: MovieViewModel) -> Bool {
		return true
	}
	
	func hash(into hasher: inout Hasher) {
		hasher.combine(movie.id)
	}
	
	var posterImage: UIImage?
	var movie: Movie
	
	init(movie: Movie, image: UIImage? = nil) {
		self.movie = movie
		self.posterImage = image
	}
}

struct Movie: Model, Hashable {
	let posterPath: String?
	let adult: Bool?
	let overview: String?
	let releaseDate: Date?
	let genreIDs: Int?
	let id: Int?
	let originalTitle: String?
	let originalLanguage: String?
	let title: String?
	let backdropPath: String?
	let popularity: Float?
	let voteCount: Int?
	let video: Bool?
	let voteAverage: Float?
	
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
