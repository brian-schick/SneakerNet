//
//  ViewController.swift
//  Nike_TopAlbumsExample
//
//  Created by Brian Schick on 2/25/20.
//  Copyright © 2020 Brian Schick. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
	
	let REUSE_IDENTIFIER = "nikeExample"
	
	var tableView: UITableView!
	var albums: [Album]!

	override func viewDidLoad() {
		super.viewDidLoad()
		mockData()
		layoutObjects()
	}

// MARK: - Private Methods
	private func layoutObjects() {
		tableView = UITableView(frame: self.view.bounds, style: UITableView.Style.plain)
		tableView.register(MainTableViewCell.self, forCellReuseIdentifier: REUSE_IDENTIFIER)
		tableView.dataSource = self
		tableView.delegate = self
		
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.tableFooterView = UIView()

		view.addSubview(tableView)
	}
	
	private func mockData() {
		let album1 = Album(name: "First Album, which has quite a long name, which presents interesting issues", artistName: "Bob", copyright: "℗ 2020 Never Broke Again, LLC", albumURL: URL(string: "https://music.apple.com/us/album/still-flexin-still-steppin/1498288784?app=music")!, artworkURL: URL(string: "https://spoof.com")!, genre: "Hippity Hop", releaseDate: Date())
		let album2 = Album(name: "Another Album", artistName: "Bob", copyright: "℗ 2020 Never Broke Again, LLC", albumURL: URL(string: "https://music.apple.com/us/album/still-flexin-still-steppin/1498288784?app=music")!, artworkURL: URL(string: "https://spoof.com")!, genre: "Hippity Hop", releaseDate: Date())
		let album3 = Album(name: "El Très", artistName: "Bob", copyright: "℗ 2020 Never Broke Again, LLC", albumURL: URL(string: "https://music.apple.com/us/album/still-flexin-still-steppin/1498288784?app=music")!, artworkURL: URL(string: "https://spoof.com")!, genre: "Hippity Hop", releaseDate: Date())
		self.albums = [album1, album2, album3]
	}
}

// MARK: - Table View Delegate
extension MainViewController: UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let detailController = DetailViewController()
		detailController.album = albums[indexPath.row]
		tableView.deselectRow(at: indexPath, animated: false)
		present(detailController, animated: true, completion: nil)
	}
}

// MARK: - Table View Data Source
extension MainViewController: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		guard albums != nil else { return 1 }
		return albums.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard albums != nil else {
			let cell = tableView.dequeueReusableCell(withIdentifier: REUSE_IDENTIFIER, for: indexPath)
			cell.textLabel?.text = "Fetching Data…"
			return cell
		}
		
		let cell = tableView.dequeueReusableCell(withIdentifier: REUSE_IDENTIFIER, for: indexPath) as! MainTableViewCell
		let album = albums[indexPath.row]
		let tempView = UIImageView()
		
		tempView.backgroundColor = .red
		cell.albumName.text = album.name
		cell.albumName.font = cell.albumName.font.withSize(16)
		cell.albumName.numberOfLines = 2
		cell.artistName.text = album.artistName
		cell.artistName.font = cell.artistName.font.withSize(14)
		cell.albumName.numberOfLines = 2

		cell.albumImage.image = UIImage(named: "tempImage")
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return "Top 100 Albums : All Genres"
	}
}
