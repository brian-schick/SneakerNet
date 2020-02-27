//
//  FeedData.swift
//  Nike_TopAlbumsExample
//
//  Created by Brian Schick on 2/27/20.
//  Copyright © 2020 Brian Schick. All rights reserved.
//

import UIKit

enum FeedData {
	public static let feedURL = URL(string: "https://rss.itunes.apple.com/api/v1/us/apple-music/top-albums/all/100/explicit.json")!
	
	private static var dataTask: URLSessionDataTask?
	private static let session = URLSession(configuration: .default)
	
	static func mock(for mainVC: MainViewController) {
		let album1 = Album(name: "First Album, which has quite a long name, and therefore presents interesting issues", artistName: "Bob", copyright: "℗ 2020 Never Broke Again, LLC", albumURL: URL(string: "https://music.apple.com/us/album/still-flexin-still-steppin/1498288784?app=music")!, artworkURL: URL(string: "https://spoof.com")!, genre: "Hippity Hop", releaseDate: Date())
		let album2 = Album(name: "Another Album", artistName: "Bill the Musician", copyright: "℗ 2020 ", albumURL: URL(string: "https://music.apple.com/us/album/still-flexin-still-steppin/1498288784?app=music")!, artworkURL: URL(string: "https://spoof.com")!, genre: "Electronica", releaseDate: Date())
		let album3 = Album(name: "El Très", artistName: "Fred", copyright: "℗ 2050", albumURL: URL(string: "https://music.apple.com/us/album/still-flexin-still-steppin/1498288784?app=music")!, artworkURL: URL(string: "https://spoof.com")!, genre: "Ambient", releaseDate: Date())
		
		mainVC.albums = [album1, album2, album3]
		mainVC.tableView.reloadData()
	}
	
	static func inject(into mainVC: MainViewController) {
		dataTask?.cancel()
		
		dataTask = session.dataTask(with: feedURL) { data, response, error in
			defer { self.dataTask = nil }
			
			guard
				error == nil,
				let data = data,
				let response = response as? HTTPURLResponse,
				response.statusCode == 200,
				let feed = try? JSONDecoder().decode(RSSFeed.self, from: data)
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
	
}

