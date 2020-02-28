//
//  FeedContent.swift
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

public struct FeedContent: Codable {
	public let albums: [Album]
}


// MARK: - Coding Keys
extension FeedContent {
	private enum CodingKeys: String, CodingKey {
		case albums = "results"
	}
}
