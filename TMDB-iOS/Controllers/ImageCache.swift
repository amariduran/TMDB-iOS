//
//  ImageCache.swift
//  TMDB-iOS
//
//  Created by Amari Duran on 10/22/21.
//

import Foundation
import UIKit

public class ImageCache {
	public static let shared = ImageCache()
	private let cache = NSCache<NSURL, UIImage>()
	
	public final func image(url: NSURL) -> UIImage? {
		cache.object(forKey: url)
	}
	
	final func load(url: NSURL, completion: @escaping (Result<UIImage?, Error>) -> Void) {
		if let cachedImage = image(url: url) {
			DispatchQueue.main.async {
				completion(.success(cachedImage))
				return
			}
		}
		
		URLSession.shared.dataTask(with: url as URL) { data, response, error in
			if let error = error {
				completion(.failure(error))
				return
			}
			
			guard let httpURLResponse = response as? HTTPURLResponse,
							(200...299).contains(httpURLResponse.statusCode) else {
				completion(.failure(NSError()))
				return
			}
			
			guard let data = data,
							let image = UIImage(data: data) else {
				completion(.failure(NSError()))
				return
			}

			self.cache.setObject(image, forKey: url)
			
			DispatchQueue.main.async {
				completion(.success(image))
			}
		}.resume()
	}
	
}
