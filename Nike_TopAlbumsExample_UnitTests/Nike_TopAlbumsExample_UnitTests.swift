//
//  Nike_TopAlbumsExample_UnitTests.swift
//  Nike_TopAlbumsExample_UnitTests
//
//  Created by Brian Schick on 2/27/20.
//  Copyright © 2020 Brian Schick. All rights reserved.
//

import XCTest

@testable import Nike_TopAlbumsExample

class Nike_TopAlbumsExample_UnitTests: XCTestCase {
	
	/*
	PLEASE NOTE: For example purposes, no common setup/teardown steps have particular value
	*/
	
	
	// MARK: - Model and Service Tests
	func test_mockRSS_feedContentNotNil() {
		let mockRSSFeed = RSSFeed.mockData()
		let mockData = try! JSONEncoder().encode(mockRSSFeed)
		let decodedFeed = try? RSSService.decode(mockData)
		
		XCTAssertNotNil(decodedFeed?.feedContent)
	}
	
	func test_mockRSS_albumCountEquals3() {
		let mockRSSFeed = RSSFeed.mockData()
		let mockData = try! JSONEncoder().encode(mockRSSFeed)
		let decodedFeed = try? RSSService.decode(mockData)
		
		XCTAssertEqual(decodedFeed?.feedContent.albums.count, 3)
	}
	
	func test_mockRSS_lastAlbumNameCorrect() {
		let mockRSSFeed = RSSFeed.mockData()
		let mockData = try! JSONEncoder().encode(mockRSSFeed)
		let decodedFeed = try? RSSService.decode(mockData)
		
		XCTAssertEqual(decodedFeed?.feedContent.albums.last?.name, "El Très")
	}
	
	func test_liveFeed_liveDataRetrieved() {
		let expectation = XCTestExpectation(description: "Wait for injection")
		let feedURL = RSSService.feedURL
		let dataTask = URLSession.shared.dataTask(with: feedURL) { data, response, error in
			
			XCTAssertNotNil(data)
			XCTAssertNil(error)
			
			expectation.fulfill()
		}
		
		dataTask.resume()
		wait(for: [expectation], timeout: 10)
	}
	
	func test_liveFeed_liveDataDecodes() {
		let expectation = XCTestExpectation(description: "Wait for injection")
		let feedURL = RSSService.feedURL
		let dataTask = URLSession.shared.dataTask(with: feedURL) { data, response, error in
			let feed = try? RSSService.decode(data!)
			
			XCTAssertNotNil(feed)
			XCTAssertNotNil(feed!.feedContent)
			XCTAssertNotNil(feed!.feedContent.albums)

			expectation.fulfill()
		}
		
		dataTask.resume()
		wait(for: [expectation], timeout: 10)
	}

	func test_liveFeed_liveDataHasExpectedAlbumCount() {
		let expectation = XCTestExpectation(description: "Wait for injection")
		let feedURL = RSSService.feedURL
		let dataTask = URLSession.shared.dataTask(with: feedURL) { data, response, error in
			let feed = try? RSSService.decode(data!)
			let albums = feed!.feedContent.albums
			
			XCTAssertEqual(albums.count, 100)
			
			expectation.fulfill()
		}
		
		dataTask.resume()
		wait(for: [expectation], timeout: 10)
	}
}


// MARK: - Date Formatter Tests
func test_dateFormatter_yyyyMMdd_dateCorrect() {
	let dateString = "2020-06-15"
	let date = DateFormatter.yyyyMMdd.date(from: dateString)
	let expectedDate = Date(timeIntervalSince1970: 1592179200)
	
	XCTAssertEqual(date, expectedDate)
}



// MARK: - MainViewController Tests
func test_mainViewController_noData_expectedItemsNil() {
	let mainViewController = MainViewController()
	
	XCTAssertNil(mainViewController.albums)
	XCTAssertNil(mainViewController.tableView)
}

func test_mainViewController_mockData_rowCountEquals3() {
	let mockRSSFeed = RSSFeed.mockData()
	let mainViewController = MainViewController()
	mainViewController.albums = mockRSSFeed.feedContent.albums
	mainViewController.viewDidLoad()
	mainViewController.tableView.reloadData()
	
	XCTAssertEqual(mainViewController.tableView.numberOfRows(inSection: 0), 3)
}

func test_mainViewController_mockData_secondRowHasExpectedArtistName() {
	let mockRSSFeed = RSSFeed.mockData()
	let mainViewController = MainViewController()
	mainViewController.albums = mockRSSFeed.feedContent.albums
	mainViewController.viewDidLoad()
	mainViewController.tableView.reloadData()
	
	let cell = mainViewController.tableView.cellForRow(at: IndexPath(row: 1, section: 0))
	let mainTableViewCell = cell as? MainTableViewCell
	
	XCTAssertNotNil(mainTableViewCell)
	XCTAssertEqual(mainTableViewCell!.albumName.text, "Another Album")
	XCTAssertEqual(mainTableViewCell!.artistName.text, "Mary the Musician")
}





// MARK: - DetailViewController Tests
func test_detailViewController_noData_expectedItemsNilAndEmpty() {
	let detailViewController = DetailViewController()
	
	XCTAssertNil(detailViewController.album)
	XCTAssertEqual(detailViewController.view.subviews.count, 0)
}

func test_detailViewController_mockdata_hasStackViewAndbutton() {
	let mockRSSFeed = RSSFeed.mockData()
	let album = mockRSSFeed.feedContent.albums.first!
	
	let detailViewController = DetailViewController()
	detailViewController.album = album
	detailViewController.viewDidLoad()
	
	let subviews = detailViewController.view.subviews
	
	XCTAssertNotNil(subviews.first)
	XCTAssertNotNil(subviews.first as? UIStackView)
	XCTAssertNotNil(subviews.last as? UIButton)
}

func test_detailViewController_mockdata_hasImageViewControlAndImage() {
	let mockRSSFeed = RSSFeed.mockData()
	let album = mockRSSFeed.feedContent.albums.first!
	
	let detailViewController = DetailViewController()
	detailViewController.album = album
	detailViewController.viewDidLoad()
	
	let stackView = detailViewController.view.subviews.first! as! UIStackView
	
	XCTAssertNotNil(stackView.subviews.first)
	XCTAssertNotNil(stackView.subviews.first as? UIImageView)
	XCTAssertNotNil((stackView.subviews.first as? UIImageView)?.image)
}




// MARK: - Private Convenience Methods
private extension RSSFeed {
	static func mockData() -> RSSFeed {
		let albums = [
			Album(name: "First Album, which has quite a long name, and therefore create interesting presentational issues", artistName: "Bob", copyright: "℗ 2020 Never Broke Again, LLC", albumURL: URL(string: "https://music.apple.com/us/album/still-flexin-still-steppin/1498288784?app=music")!, artworkURL: URL(string: "https://spoof.com")!, genre: "Hippity Hop", releaseDate: Date()),
			Album(name: "Another Album", artistName: "Mary the Musician", copyright: "℗ 2020 ", albumURL: URL(string: "https://music.apple.com/us/album/still-flexin-still-steppin/1498288784?app=music")!, artworkURL: URL(string: "https://spoof.com")!, genre: "Electronica", releaseDate: Date()),
			Album(name: "El Très", artistName: "Art the Artist", copyright: "℗ 2050", albumURL: URL(string: "https://music.apple.com/us/album/still-flexin-still-steppin/1498288784?app=music")!, artworkURL: URL(string: "https://spoof.com")!, genre: "Ambient", releaseDate: Date()),
		]
		return RSSFeed(feedContent: FeedContent(albums: albums))
	}
}
