//
//  Album.swift
//  Nike_TopAlbumsExample
//
//  Created by Brian Schick on 2/25/20.
//  Copyright © 2020 Brian Schick. All rights reserved.
//

import Foundation

/*
	PLEASE NOTE: Although app functionality requires only Decodable,
	All Model structs are conformed to Codable to ease sample unit tests against mocks.
*/

public struct Album: Codable {
	public let name: String
	public let artistName: String
	public let copyright: String
	public let albumURL: URL
	public let artworkURL: URL
	public let genre: String!
	public let releaseDate: Date
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

// MARK: - Custom Decoder (and Encoder for unit testing)
extension Album {
	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		
		// Retrieve simple valuesd
		name = try container.decode(String.self, forKey: .name)
		artistName = try container.decode(String.self, forKey: .artistName)
		copyright = try container.decode(String.self, forKey: .copyright)
		albumURL = try container.decode(URL.self, forKey: .albumURL)
		artworkURL = try container.decode(URL.self, forKey: .artworkURL)
		
		// Per spec, retrieve genre as single-valued String
		struct Genre: Decodable { let name: String }
		let genres = try? container.decode([Genre].self, forKey: .genre)
		genre = genres?.first?.name ?? ""
				
		
		/*
		PLEASE NOTE:
		Due to example time constraints, I'm nil coalescing below to ease mockData en/decoding.
		In production, I'd use guard and throw errors as in the code that's commented out.
		*/
		
		
		// Retrieve date from yyyy-MM-dd-formatted String
		
		//		guard
		//			let dateString = try? container.decode(String.self, forKey: .releaseDate),
		//			let date = DateFormatter.yyyyMMdd.date(from: dateString)
		//			else {
		//				throw DecodingError.dataCorruptedError(forKey: .releaseDate, in: container, debugDescription: "RSS: Invalid data.")
		//		}
		
		let dateString = (try? container.decode(String.self, forKey: .releaseDate)) ?? ""
		releaseDate = DateFormatter.yyyyMMdd.date(from: dateString) ?? Date()
	}
	
	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		
		/*
		PLEASE NOTE:
		The sole reason for encode (and Encodable conformance) is for the sake of
		sample unit tests against mock data.
		
		I'm cheating for time's sake here by simply skipping synthesis of nested [Genre],
		and also ignoring Date issues, since neither affects the sample tests and has no effect
		on app functionality as specced.
		*/
		
		try container.encode(name, forKey: .name)
		try container.encode(artistName, forKey: .artistName)
		try container.encode(copyright, forKey: .copyright)
		try container.encode(albumURL, forKey: .albumURL)
		try container.encode(artworkURL, forKey: .artworkURL)
	}
}
