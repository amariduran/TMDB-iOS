//
//  TMDBMovie.swift
//  TMDB-iOS
//
//  Created by Amari Duran on 10/9/21.
//

import Foundation
import SimpleNetworking

struct TMDBMovie {
	static let baseURL = URL(string: "https://api.themoviedb.org/3")!
	
	static var api: APIClient = {
		let configuration = URLSessionConfiguration.default
		
		// With v4 of TMDB a Bearer token is now being used for all user authentication but the
		// ability to use this token with v3 is also supported. Using the Bearer token has the added
		// benefit of being a single authentication process that can be used across both v3 and v4 methods.
		if let accessToken = Bundle.main.infoDictionary?["APIReadAccessToken"] as? String {
			configuration.httpAdditionalHeaders = [
				"Authorization": "Bearer \(accessToken)"
			]
		}
		
		return APIClient(configuration: configuration, adapters: [LoggingAdapter(logLevel: .info)])
	}()
}
