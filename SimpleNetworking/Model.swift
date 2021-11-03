//
//  Model.swift
//  SimpleNetworking
//
//  Created by Cleopatra on 10/14/21.
//

import Foundation

// Leverage Codable for parsing JSON into model objects.
// Common protocol that all response models can implement. For many of them, the default decoder will do.
public protocol Model: Codable {
	static var decoder: JSONDecoder { get }
	static var encoder: JSONEncoder { get }
}

public extension Model {
	static var decoder: JSONDecoder {
		let decoder = JSONDecoder()
		decoder.keyDecodingStrategy = .convertFromSnakeCase
		return decoder
	}
	
	static var encoder: JSONEncoder {
		let encoder = JSONEncoder()
		encoder.keyEncodingStrategy = .convertToSnakeCase
		return encoder
	}
}
