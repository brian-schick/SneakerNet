//
//  FeedContent.swift
//  Nike_TopAlbumsExample
//
//  Created by Brian Schick on 2/25/20.
//  Copyright © 2020 Brian Schick. All rights reserved.
//

import Foundation

public struct FeedContent: Codable {
	public let albums: [Album]
}


// MARK: - Coding Keys
extension FeedContent {
	private enum CodingKeys: String, CodingKey {
		case albums = "results"
	}
}
