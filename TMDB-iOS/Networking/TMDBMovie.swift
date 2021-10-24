//
//  TMDBMovie.swift
//  TMDB-iOS
//
//  Created by Amari Duran on 10/9/21.
//

import Foundation
import SimpleNetworking

struct TMDBMovie {
	static let baseURL = URL(string: "https://api.themoviedb.org/3/")!
	
	static var api: APIClient = {
		let configuration = URLSessionConfiguration.default
		
		if let apiKey = Bundle.main.infoDictionary?["APIV4AuthKey"] as? String {
			configuration.httpAdditionalHeaders = [
				"Authorization": "Bearer \(apiKey)"
			]
		}
		
		let apiClient = APIClient(configuration: configuration,
															adapters: [
																LoggingAdapter(logLevel: .info)
															])
		return apiClient
	}()
}
