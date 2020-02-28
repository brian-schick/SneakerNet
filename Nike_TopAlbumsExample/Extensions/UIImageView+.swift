////
////  UIImageView+.swift
////  Nike_TopAlbumsExample
////
////  Created by Brian Schick on 2/27/20.
////  Copyright © 2020 Brian Schick. All rights reserved.
////
//
//import UIKit
//
//extension UIImageView {
//	func downloadImageFrom(_ url: URL) {
//
//		let dataTask: URLSessionDataTask?
//		let session = URLSession(configuration: .default)
//
//		dataTask = session.dataTask(with: url) { data, response, error in
//
//			guard
//				error == nil,
//				let data = data,
//				let response = response as? HTTPURLResponse,
//				response.statusCode == 200,
//				let feed = try? JSONDecoder().decode(RSSFeed.self, from: data)
//				else {
//					return
//			}
//
//
//		}
//
//
//
////		URLSession.sharedSession().dataTaskWithURL( NSURL(string:link)!, completionHandler: {
////			(data, response, error) -> Void in
////			dispatch_async(dispatch_get_main_queue()) {
////				self.contentMode =  contentMode
////				if let data = data { self.image = UIImage(data: data) }
////			}
////		}).resume()
////	}
//}
