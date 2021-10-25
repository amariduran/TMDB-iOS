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
	
	func load(url: NSURL, _ completion: @escaping (UIImage?, Error?) -> Void) {
		let task = URLSession.shared.downloadTask(with: url as URL) { localURL, response, error in
			if let error = error {
				completion(nil, error)
			}
			
			guard let httpURLResponse = response as? HTTPURLResponse,
							(200...299).contains(httpURLResponse.statusCode) else {
				completion(nil, NSError())
				return
			}
			
			guard let localURL = localURL else {
				completion(nil, NSError())
				return
			}
			
			do {
				let data = try Data(contentsOf: localURL)
				let image = UIImage(data: data)
				completion(image, nil)
			} catch {
				completion(nil, error)
			}
		}
		task.resume()
	}
	
}
