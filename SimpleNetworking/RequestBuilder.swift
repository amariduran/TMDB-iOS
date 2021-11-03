//
//  RequestBuilder.swift
//  SimpleNetworking
//
//  Created by Cleopatra on 10/14/21.
//

import Foundation

/*
 Protocol to model requests and which is also responsible for creating URLRequest instances. This will
 hold all of the information necessary to build the request.
 */
public protocol RequestBuilder {
	var method: HTTPMethod { get }
	var baseURL: URL { get }
	var path: String { get }
	var params: [URLQueryItem]? { get }
	var headers: [String : String] { get }
	
	func toURLRequest() -> URLRequest
}

public extension RequestBuilder {
	func toURLRequest() -> URLRequest {
		var components = URLComponents(url: baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: false)!
		components.queryItems = params
		
		var request = URLRequest(url: components.url!)
		request.allHTTPHeaderFields = headers
		request.httpMethod = method.rawValue.uppercased()
		return request
	}
}

struct BasicRequestBuilder: RequestBuilder {
	var method: HTTPMethod
	var baseURL: URL
	var path: String
	var params: [URLQueryItem]?
	var headers: [String : String] = [:]
}

struct PostRequestBuilder<Body: Model>: RequestBuilder {
	var method: HTTPMethod
	var baseURL: URL
	var path: String
	var params: [URLQueryItem]?
	var headers: [String : String] = [:]
	var body: Body?
	
	init(method: HTTPMethod = .post, baseURL: URL, path: String, params: [URLQueryItem]? = nil, body: Body?) {
		self.method = method
		self.baseURL = baseURL
		self.path = path
		self.params = params
		self.body = body
		self.headers["Content-Type"] = "application/json"
	}
	
	func encodeRequestBody() -> Data? {
		guard let body = body else { return nil }
		
		do {
			let encoder = Body.encoder
			return try encoder.encode(body)
		} catch {
			print("Error encoding request body: \(error)")
			return nil
		}
	}
}
