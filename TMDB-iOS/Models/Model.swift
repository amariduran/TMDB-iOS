//
//  Model.swift
//  TMDB-iOS
//
//  Created by Cleopatra on 10/9/21.
//

import Foundation

// Leverage Codable for parsing JSON into model objects.
// Common protocol that all response models can implement. For many of them, the default decoder will do.
protocol Model: Decodable {
	// Models should provide their own decoders.
	static var decoder: JSONDecoder { get }
}

extension Model {
	// Provide default implementation that will work for most Codable models.
	static var decoder: JSONDecoder {
		let decoder = JSONDecoder()
		decoder.keyDecodingStrategy = .convertFromSnakeCase
		return decoder
	}
}
