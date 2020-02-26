//
//  Album.swift
//  Nike_TopAlbumsExample
//
//  Created by Brian Schick on 2/25/20.
//  Copyright © 2020 Brian Schick. All rights reserved.
//

import Foundation

public struct Album: Decodable {
	public let name: String
	public let artistName: String
	public let copyright: String
	public let releaseDate: Date
	public let albumURL: URL
	public let artworkURL: URL
	public let genre: String
}


// MARK: - Custom Coding Keys
extension Album {
	private enum CodingKeys: String, CodingKey {
		case artistName, copyright, releaseDate, name
		case albumURL = "url"
		case artworkURL = "artworkUrl100"
		case genre = "genres"
	}
}


// MARK: - Custom Decoder
extension Album {
	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		
		name = try container.decode(String.self, forKey: .name)
		artistName = try container.decode(String.self, forKey: .artistName)
		copyright = try container.decode(String.self, forKey: .copyright)
		albumURL = try container.decode(URL.self, forKey: .albumURL)
		artworkURL = try container.decode(URL.self, forKey: .artworkURL)
		
		// Per instructions, genre is to be a single value
		let genres = try container.decode([Genre].self, forKey: .genre)
		guard let firstGenre = genres.first else {
			throw DecodingError.dataCorruptedError(forKey: .genre, in: container, debugDescription: "RSS: Required genre missing.")
		}
		genre = firstGenre.name
		
		guard
			let dateString = try? container.decode(String.self, forKey: .releaseDate),
			let date = DateFormatter.yyyyMMdd.date(from: dateString)
			else {
				throw DecodingError.dataCorruptedError(forKey: .releaseDate, in: container, debugDescription: "RSS: Invalid data.")
		}
		releaseDate = date
	}
}
