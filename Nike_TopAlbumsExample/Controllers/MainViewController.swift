//
//  ViewController.swift
//  Nike_TopAlbumsExample
//
//  Created by Brian Schick on 2/25/20.
//  Copyright © 2020 Brian Schick. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController {
	
	let REUSE_IDENTIFIER = "nikeExample"
	
	public var tableView: UITableView!
	public var albums: [Album]!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		layoutObjects()
	}
	
	// MARK: - Private Methods
	private func layoutObjects() {
		view.backgroundColor = .systemBackground
		
		tableView = UITableView(frame: self.view.bounds, style: UITableView.Style.plain)
		tableView.register(MainTableViewCell.self, forCellReuseIdentifier: REUSE_IDENTIFIER)
		tableView.dataSource = self
		tableView.delegate = self
		
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.tableFooterView = UIView()
		tableView.accessibilityIdentifier = "Albums Table View"
		view.addSubview(tableView)
		
		let views = ["tableView" : tableView!]
		var constraints: [NSLayoutConstraint] = []
		constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|[tableView]|", options: [], metrics: nil, views: views)
		constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-[tableView]-|", options: [], metrics: nil, views: views)
		NSLayoutConstraint.activate(constraints)
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
		
		// If albums not yet injected, display single "Fetching..." row and return immediately
		guard albums != nil else {
			let cell = tableView.dequeueReusableCell(withIdentifier: REUSE_IDENTIFIER, for: indexPath)
			cell.textLabel?.text = "Fetching Data…"
			return cell
		}
		
		// Configure album cell
		let cell = tableView.dequeueReusableCell(withIdentifier: REUSE_IDENTIFIER, for: indexPath) as! MainTableViewCell
		let album = albums[indexPath.row]
		
		// Clear "Fetching..." text if present
		cell.textLabel?.text = ""
		
		// Album Name
		cell.albumName.text = album.name
		cell.albumName.font = cell.albumName.font.withSize(16)
		cell.albumName.numberOfLines = 2
		
		// Artist Name
		cell.artistName.text = album.artistName
		cell.artistName.font = cell.artistName.font.withSize(14)
		cell.artistName.numberOfLines = 2
		
		// Album Image
		cell.albumImage.image = UIImage(named: "placeholderImage")
		ImageCache.image(for: album.artworkURL) { image in
			cell.albumImage.image = image
		}
		
		cell.accessibilityIdentifier = "Table row for \(album.name)"
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return "Top 100 Albums : All Genres"
	}
}
