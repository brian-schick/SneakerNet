//
//  ImageCache.swift
//  Nike_TopAlbumsExample
//
//  Created by Brian Schick on 2/27/20.
//  Copyright © 2020 Brian Schick. All rights reserved.
//

import UIKit

typealias CachedImageLoader = ((UIImage) -> ())

public final class ImageCache {
	
	private static var cached: [URL : UIImage] = [:]
	
	public static func image(for url: URL, completionHandler: @escaping (UIImage) -> Void) {
		
		if let cachedImage = cached[url] {
			completionHandler(cachedImage)
			return
		}
		
		let request = URLRequest(url: url)
		let session = URLSession.shared
		let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
			guard
				error == nil,
				let data = data,
				let image = UIImage(data: data)
			else {
				return
			}
			
			cached[url] = image
			DispatchQueue.main.async {
				completionHandler(image)
			}
		})
		
		task.resume()
	}
}
