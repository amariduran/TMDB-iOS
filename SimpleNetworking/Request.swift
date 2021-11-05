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


/*
 Created an extension (limited to Result<Data, APIError>). This is a cool feature of Swift that allows
 you to create readable code without polluting the namespace of all Result types. Only ones that match
 our Success and Failure types will get this method.
 
 Map the success type of result. Started with Result<Data, APIError> and the flatMap()
 method returns a Result<M, APIError>.
 */
public extension Result where Success == Data, Failure == APIError {
	
	/*
	 Since our decodable type M matches the completion block, these parameters line up perfectly and allow us
	 to express our intent with great clarity: take the result, decode into this type, then call this completion.
	 */
	func decoding<M: Model>(_ model: M.Type, completion: @escaping (Result<M, APIError>) -> Void) {
		DispatchQueue.global().async {
			let result = self.flatMap { data -> Result<M, APIError> in
				do {
					let decoder = M.decoder
					let model = try decoder.decode(M.self, from: data)
					return .success(model)
					
				} catch let error as DecodingError {
					return .failure(.decodingError(error))
					
				} catch {
					// Unlikely to occur, but Swift won't let us just catch decoding errors.
					return .failure(APIError.unhandledResponse)
				}
			}
			
			DispatchQueue.main.async {
				completion(result)
			}
		}
	}
	
}
