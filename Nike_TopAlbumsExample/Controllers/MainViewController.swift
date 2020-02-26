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
	var albums: [Album]!

	override func viewDidLoad() {
		super.viewDidLoad()

		mockData()
		layoutObjects()
	}


	
	private func layoutObjects() {
		var tableView = UITableView()
		tableView = UITableView(frame: self.view.bounds, style: UITableView.Style.plain)
		tableView.register(MainTableViewCell.self, forCellReuseIdentifier: REUSE_IDENTIFIER)
		tableView.dataSource = self
		tableView.delegate = self
		
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.tableFooterView = UIView()
		let insets = UIEdgeInsets(top: 20.0, left: 0.0, bottom: 0.0, right: 0.0)
		tableView.contentInset = insets
		tableView.scrollIndicatorInsets = insets
		tableView.rowHeight = 80
		view.addSubview(tableView)
	}
	
	private func mockData() {
		let album1 = Album(name: "First Album", artistName: "Bob", copyright: "2021", releaseDate: Date(), albumURL: URL(string: "https://spoof.com")!, artworkURL: URL(string: "https://spoof.com")!, genre: "Hippity Hop")
		self.albums = [album1]
	}
	
	
	

}





// MARK: - TableView Conformance
extension MainViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let detailController = DetailViewController()
		//		detailController.modalTransitionStyle = .CrossDissolve
		present(detailController, animated: true, completion: nil)
	}
	
}

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
		cell.artistName.text = album.artistName
		
		cell.albumImage.image = UIImage(named: "tempImage")
//		cell.al = album.artistName
		
		return cell
	}
	
	
}