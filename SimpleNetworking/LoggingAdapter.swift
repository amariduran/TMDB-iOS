//
//  LoggingAdapter.swift
//  SimpleNetworking
//
//  Created by Cleopatra on 10/14/21.
//

import Foundation

public struct LoggingAdapter: RequestAdapter {
	public enum LogLevel: Int {
		case none
		case info
		case debug
	}
	
	struct Log {
		var level: LogLevel = .info
		
		/*
		 Using @autoclosure for the message instead of just a raw string to avoid all string interpolation work
		 if the log level will just filter this message out anyway. No need for logging to make
		 the code slower if it's turned off.
		 */
		public func message(_ msg: @autoclosure () -> String, level: LogLevel) {
			guard level.rawValue <= self.level.rawValue else { return }
			print(msg())
		}
		
		public func message(_ utf8Data: @autoclosure () -> Data?, level: LogLevel) {
			guard level.rawValue <= self.level.rawValue else { return }
			
			let stringValue = utf8Data().flatMap { String(data: $0, encoding: .utf8) } ?? "<empty>"
			message(stringValue, level: level)
		}
	}
		
	private let log: Log
	
	public init(logLevel: LogLevel = .info) {
		log = Log(level: logLevel)
	}
	
	public func beforeSend(_ request: URLRequest) {
		guard let url = request.url?.absoluteString else { return }
		
		let httpMethod = request.httpMethod ?? ""
		log.message("📡 \(httpMethod) \(url)", level: .info)
		
		if let httpBody = request.httpBody {
			log.message("Request HTTP body:", level: .debug)
			log.message(httpBody, level: .debug)
		}
	}
	
	public func onResponse(response: URLResponse?, data: Data?) {
		guard let httpURLResponse = response as? HTTPURLResponse else { return }
		
		log.message("⬇️ Received HTTP \(httpURLResponse.statusCode) from \(httpURLResponse.url?.absoluteString ?? "<?>")", level: .info)
		log.message("Body: ", level: .debug)
		log.message(data, level: .debug)
	}
	
	public func onError(request: URLRequest, error: APIError) {
		log.message("❌ ERROR: \(error)", level: .info)
	}
	
}
