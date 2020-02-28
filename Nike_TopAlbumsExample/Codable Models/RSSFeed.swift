//
//  RSSFeed.swift
//  Nike_TopAlbumsExample
//
//  Created by Brian Schick on 2/25/20.
//  Copyright © 2020 Brian Schick. All rights reserved.
//

import Foundation

/*
	PLEASE NOTE: Although app functionality requires on Decodable,
	All Model structs are conformed to Codable to ease sample unit tests against mocks.
*/

public struct RSSFeed: Codable {
	let feedContent: FeedContent
}

// MARK: - Coding Keys
extension RSSFeed {
	
	private enum CodingKeys: String, CodingKey {
		case feedContent = "feed"
	}
}
