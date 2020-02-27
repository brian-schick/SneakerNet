//
//  DetailViewController.swift
//  Nike_TopAlbumsExample
//
//  Created by Brian Schick on 2/26/20.
//  Copyright © 2020 Brian Schick. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
	
	var album: Album!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		layoutObjects()
	}
	
	
	@objc func viewButtonTapped() {
		// TODO: `open()` raises a "Can't end BackgroundTask" error per https://forums.developer.apple.com/thread/121990
		// This appears to be an iOS 13 bug - I'm not pursuing this for purposes of this exercise
		
		let itunesStorePrefix = "itms://itunes.apple.com/"
		let albumSuffix = album.albumURL.pathComponents.dropFirst().joined(separator: "/")
		guard let url = URL(string: itunesStorePrefix + albumSuffix), UIApplication.shared.canOpenURL(url) else { return }

		UIApplication.shared.open(url)
	}
	
	
	// MARK: - Private Methods
	private func layoutObjects() {
		guard let album = album else { return }
		view.backgroundColor = .systemBackground
		
		// Instantiate Album Info Controls
		let albumImageView = UIImageView(image: UIImage(named: "tempImage")) // TEMP: REPLACE WITH LIVE
		
		let nameLabel = UILabel()
		nameLabel.text = album.name
		nameLabel.font = nameLabel.font.withSize(20)
		nameLabel.numberOfLines = 0
		
		let artistLabel = UILabel()
		artistLabel.text = "Artist: \(album.artistName)"
		artistLabel.font = artistLabel.font.withSize(15)
		artistLabel.numberOfLines = 0
		
		let genreLabel = UILabel()
		genreLabel.text = "Genre: \(album.genre)"
		genreLabel.font = genreLabel.font.withSize(15)
		
		let releaseLabel = UILabel()
		releaseLabel.text = "Release Date: \(DateFormatter.friendly.string(from: album.releaseDate))"
		releaseLabel.font = releaseLabel.font.withSize(15)
		
		let copyright = UILabel()
		copyright.text = "Copyright: \(album.copyright)"
		copyright.numberOfLines = 0
		copyright.font = copyright.font.withSize(15)
		
		// Instantiate Stack View and add album info controls
		let stackView = UIStackView()
		stackView.axis = .vertical
		stackView.distribution = .fill
		stackView.alignment = .leading
		stackView.spacing = 16.0
		
		stackView.addArrangedSubview(albumImageView)
		stackView.addArrangedSubview(nameLabel)
		stackView.addArrangedSubview(artistLabel)
		stackView.addArrangedSubview(genreLabel)
		stackView.addArrangedSubview(releaseLabel)
		stackView.addArrangedSubview(copyright)
		stackView.translatesAutoresizingMaskIntoConstraints = false
		
		view.addSubview(stackView)
		
		// Add View in iTunes Button, placing directly on View
		let viewButton = UIButton()
		viewButton.setTitle("View in iTunes Store", for: .normal)
		viewButton.translatesAutoresizingMaskIntoConstraints = false
		viewButton.backgroundColor = .systemBlue
		viewButton.setTitleColor(.white, for: .normal)
		viewButton.addTarget(self, action: #selector(self.viewButtonTapped), for: .touchUpInside)
		view.addSubview(viewButton)
		
		// Add Auto Layout constraints
		stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
		stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
		
		albumImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
		albumImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
		
		// per spec, pin button 20 points from view's leading/trailing and bottom edges
		viewButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
		viewButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
		viewButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
	}
}
