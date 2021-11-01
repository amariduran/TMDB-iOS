//
//  MovieDate.swift
//  TMDB-iOS
//
//  Created by Amari Duran on 10/28/21.
//

import Foundation
import SimpleNetworking

struct MovieDate: Model, Hashable {
	let maximum: Date?
	let minimum: Date?
}
