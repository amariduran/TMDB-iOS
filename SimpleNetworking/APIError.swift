//
//  APIError.swift
//  SimpleNetworking
//
//  Created by Cleopatra on 10/14/21.
//

import Foundation

public enum APIError: Error {
	/// If our response is not an HTTPURLResponse.
	case unknownResponse
	/// The request could not be made (due to a timeout, missing connectivity, offline, etc). The associated values provides the underlying reason.
	case networkError(Error)
	/// The request was made but the response indicated the reqeuest was invalid. This can be for missing params, authentication, etc. Associated values
	/// provides the HTTP Status Code. (HTTP 4xx)
	case requestError(Int)
	/// The request was made but the response indicated the server had an error. Associated value provides the HTTP Status Code. (HTTP 5xx)
	case serverError(Int)
	case decodingError(DecodingError)
	case unhandledResponse
}

public extension APIError {
	static func error(from response: URLResponse?) -> APIError? {
		guard let httpURLResponse = response as? HTTPURLResponse else {
			return .unknownResponse
		}
		
		switch httpURLResponse.statusCode {
		case 200...299: return nil
		case 400...499: return .requestError(httpURLResponse.statusCode)
		case 500...599: return .serverError(httpURLResponse.statusCode)
		default: return .unhandledResponse
		}
	}
	
	var localizedDescription: String {
		switch self {
		case .unknownResponse: return "Unknown response"
		case .networkError(let error): return "Network Error: \(error.localizedDescription)"
		case .requestError(let statusCode): return "Request error (HTTP \(statusCode))"
		case .serverError(let statusCode): return "Server error (HTTP \(statusCode))"
		case .decodingError(let error): return "Decoding error: \(error)"
		case .unhandledResponse: return "Unhandled response"
		}
	}
	
	var description: String {
		localizedDescription
	}
}
