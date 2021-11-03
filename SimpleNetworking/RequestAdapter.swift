//
//  RequestAdapter.swift
//  SimpleNetworking
//
//  Created by Cleopatra on 10/14/21.
//

import Foundation

/*
 Request adapter allows extending the networking system to add behavior without constantly adding
 more bloat to the API Client type.
 */
public protocol RequestAdapter {
	func adapt(_ request: inout URLRequest)
	func beforeSend(_ request: URLRequest)
	func onResponse(response: URLResponse?, data: Data?)
	func onError(request: URLRequest, error: APIError)
	func onSuccess(request: URLRequest)
}

// Default empty implementations written as methods should be optional.
public extension RequestAdapter {
	func adapt(_ request: inout URLRequest) { }
	func beforeSend(_ request: URLRequest) { }
	func onResponse(response: URLResponse?, data: Data?) { }
	func onError(request: URLRequest, error: APIError) { }
	func onSuccess(request: URLRequest) { }
}
