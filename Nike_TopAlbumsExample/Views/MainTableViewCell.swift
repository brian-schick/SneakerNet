//
//  MainTableViewCell.swift
//  Nike_TopAlbumsExample
//
//  Created by Brian Schick on 2/26/20.
//  Copyright © 2020 Brian Schick. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {
	
	public let REUSE_IDENTIFIER = "nikeExample"

	let albumName = UILabel()
	let artistName = UILabel()
	var albumImage = UIImageView()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		let views = ["albumName" : albumName, "artistName" : artistName, "albumImage" : albumImage]
		
		albumName.translatesAutoresizingMaskIntoConstraints = false
		artistName.translatesAutoresizingMaskIntoConstraints = false
		albumImage.translatesAutoresizingMaskIntoConstraints = false
		
		contentView.addSubview(albumName)
		contentView.addSubview(artistName)
		contentView.addSubview(albumImage)
		
		var constraints: [NSLayoutConstraint] = []
		constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-[albumImage(50@750)]-[albumName]-|", options: [], metrics: nil, views: views)
		constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-[albumImage(50@750)]-[artistName]-|", options: [], metrics: nil, views: views)
		constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-[albumImage]-|", options: [], metrics: nil, views: views)
		constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-[albumName]-[artistName]-|", options: [], metrics: nil, views: views)
		
		albumImage.widthAnchor.constraint(equalTo: albumImage.heightAnchor, multiplier: 1.0).isActive = true
		
		NSLayoutConstraint.activate(constraints)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
//	override func setSelected(_ selected: Bool, animated: Bool) {
//		super.setSelected(selected, animated: animated)
//		MainViewController.presentDetailView(<#T##self: MainViewController##MainViewController#>)
//	}
}
