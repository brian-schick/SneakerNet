//
//  RSSService.swift
//  Nike_TopAlbumsExample
//
//  Created by Brian Schick on 2/27/20.
//  Copyright © 2020 Brian Schick. All rights reserved.
//

public enum ExampleError: Error {
	case rssFetchFailure
	case rssDecodeFailure
}

import UIKit

public enum RSSService {
	
	typealias TaskClosureElements = (data: Data?, response: URLResponse?, error: Error?)
	
	public static let feedURL = URL(string: "https://rss.itunes.apple.com/api/v1/us/apple-music/top-albums/all/100/explicit.json")!
	
	private static let session = URLSession(configuration: .default)
	private static var dataTask: URLSessionDataTask?
	
	static func inject(into mainVC: MainViewController) {
		dataTask?.cancel()
		
		dataTask = session.dataTask(with: feedURL) { data, response, error in
			defer { self.dataTask = nil }
			
			guard
				let data = try? retrievedData(for: (data, response, error)),
				let feed = try? decode(data)
			else {
				return
			}
			
			DispatchQueue.main.async {
				mainVC.albums = feed.feedContent.albums
				mainVC.tableView.reloadData()
			}
		}
		
		dataTask?.resume()
	}
	
	// MARK: - Internal Methods
	static func retrievedData(for closureElements: TaskClosureElements) throws -> Data {
		guard
			closureElements.error == nil,
			let data = closureElements.data
			else {
				throw ExampleError.rssFetchFailure
		}
		return data
	}
	
	static func decode(_ data: Data) throws -> RSSFeed {
		do {
			return try JSONDecoder().decode(RSSFeed.self, from: data)
		} catch {
			print(error)
			throw ExampleError.rssDecodeFailure
		}
	}
}
