//
//  Request.swift
//  SimpleNetworking
//
//  Created by Amari Duran on 10/14/21.
//

import Foundation

public struct Request {
	public typealias RequestCompletion = (Result<Data, APIError>) -> Void
	
	let builder: RequestBuilder
	let completion: RequestCompletion
	
	init(builder: RequestBuilder, completion: @escaping RequestCompletion) {
		self.builder = builder
		self.completion = completion
	}
}
	
public extension Request {
	
	static func basic(method: HTTPMethod = .get,
										baseURL: URL,path: String,
										params: [URLQueryItem]? = nil,
										completion: @escaping RequestCompletion) -> Request {
		let builder = BasicRequestBuilder(method: method, baseURL: baseURL, path: path, params: params)
		return Request(builder: builder, completion: completion)
	}
	
	static func post<Body: Model>(method: HTTPMethod = .post,
																baseURL: URL,
																path: String,
																params: [URLQueryItem]? = nil,
																body: Body?,
																completion: @escaping (Result<Data, APIError>) -> Void) -> Request {
		let builder = PostRequestBuilder(method: method, baseURL: baseURL, path: path, params: params, body: body)
		return Request(builder: builder, completion: completion)
	}
	
}

