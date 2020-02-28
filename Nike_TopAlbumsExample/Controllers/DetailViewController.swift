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
		/*
		NOTE: There are 2 issues here that I cannot address within exercise scope but should note:
		
		1. Calling 'open()` raises a "Can't end BackgroundTask" error both in simulator and on device
		This appears to be a continuing iOS 13 bug, per https://forums.developer.apple.com/thread/121990
		
		2. Per the spec provided, this functionality should open the album page "in the iTunes Store."
		In the simulator, this fails with OSStatus error -10814: "kLSApplicationNotFoundErr".
		I believe the error is caused quite simply because the iTunes Store is absent on the simulator.
		This works without isue on device, provided that the iTunes Store app is installed.
		*/
		
		let itunesStorePrefix = "itms://itunes.apple.com/"
		let albumSuffix = album.albumURL.pathComponents.dropFirst().joined(separator: "/")
		guard
			let url = URL(string: itunesStorePrefix + albumSuffix),
			UIApplication.shared.canOpenURL(url)
		else {
			return
		}
		UIApplication.shared.open(url)
	}
	
	
	// MARK: - Private Methods
	private func layoutObjects() {
		guard let album = album else { return }
		view.backgroundColor = .systemBackground
		
		// Instantiate Album Info Controls
		let albumImageView = UIImageView(image: UIImage(named: "placeholderImage"))
		ImageCache.image(for: album.artworkURL) { image in
			albumImageView.image = image
		}
		
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
		viewButton.backgroundColor = .clear
		viewButton.layer.cornerRadius = 10
		viewButton.layer.backgroundColor = UIColor.systemBlue.cgColor
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
		viewButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
	}
}
