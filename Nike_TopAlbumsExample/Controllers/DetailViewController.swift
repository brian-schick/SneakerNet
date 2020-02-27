//
//  DetailViewController.swift
//  Nike_TopAlbumsExample
//
//  Created by Brian Schick on 2/26/20.
//  Copyright © 2020 Brian Schick. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
	
//	var albumImage: UIImage
	var album: Album!

	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .lightGray
		layoutObjects()
	}

	
	private func layoutObjects() {
		guard let album = album else { return }
		
		let albumImageView = UIImageView(image: UIImage(named: "tempImage"))
		
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
		
		self.view.addSubview(stackView)
		
		stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
		stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
		
		albumImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
		albumImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
	}

	
	
	
}
