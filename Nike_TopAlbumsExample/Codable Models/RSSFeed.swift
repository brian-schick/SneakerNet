//
//  RSSFeed.swift
//  Nike_TopAlbumsExample
//
//  Created by Brian Schick on 2/25/20.
//  Copyright © 2020 Brian Schick. All rights reserved.
//

import Foundation

public struct RSSFeed: Decodable {
	let feedContent: FeedContent
}


// MARK: - Coding Keys
extension RSSFeed {
	private enum CodingKeys: String, CodingKey {
		case feedContent = "feed"
	}
}
