//
//  Result+.swift
//  TMDB-iOS
//
//  Created by Cleopatra on 10/9/21.
//

import Foundation
import SimpleNetworking

/*
 Created an extension (limited to Result<Data, APIError>). This is a cool feature of Swift that allows
 you to create readable code without polluting the namespace of all Result types. Only ones that match
 our Success and Failure types will get this method.
 
 Map the success type of result. Started with Result<Data, APIError> and the flatMap()
 method returns a Result<M, APIError>.
 */
extension Result where Success == Data, Failure == APIError {
	
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

