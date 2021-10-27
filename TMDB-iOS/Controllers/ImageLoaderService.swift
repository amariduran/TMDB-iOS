//
//  ImageLoaderService.swift
//  TMDB-iOS
//
//  Created by Amari Duran on 10/25/21.
//

import Combine
import UIKit.UIImage

class ImageLoaderService {
	
	private let cache = ImageCache()
	
//	func loadImage(from url: URL) -> AnyPublisher<UIImage?, Never> {
//		if let image = cache.image(url: url as NSURL) {
//			return Just(image)
//		}
//
//		URLSession.shared
//		 // Ourput of URLSession.DataTaskPublisher has data and response. We need to manipulate the data.
//		 // So, we have introduced a series of operations on the publisher.
//			.dataTaskPublisher(for: url)
//			.map { UIImage(data: $0.data) } // map will try to get the image from data
//		  // If we are unable to fetch the image and end up with an error this will replace the error with nil
//			.replaceError(with: nil)
//			.receive(on: DispatchQueue.main, options: nil) // update UI on main thread so we will receieve on main queue here
//			.handleEvents(receiveOutput: { [unowned self] image in
//				guard let image = image else { return }
////				self.cache.insertImage(image, for: url)
//			})
//			.eraseToAnyPublisher()
//	}
	
}
