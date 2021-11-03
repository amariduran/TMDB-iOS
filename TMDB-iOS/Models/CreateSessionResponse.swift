//
//  CreateSessionResponse.swift
//  TMDB-iOS
//
//  Created by Amari Duran on 10/31/21.
//

import Foundation
import SimpleNetworking

struct CreateSessionResponse: Model {
	let success: Bool
	let sessionId: String
}
