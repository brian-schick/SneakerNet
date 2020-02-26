//
//  DetailViewController.swift
//  Nike_TopAlbumsExample
//
//  Created by Brian Schick on 2/26/20.
//  Copyright © 2020 Brian Schick. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		layoutObjects()
		
	}

	
	private func layoutObjects() {
//		var scrollView = UIScrollView(frame: self.view.bounds)
//		scrollView.translatesAutoresizingMaskIntoConstraints = false
//		view.addSubview(scrollView)
		
		let button = UIButton()
		button.titleLabel?.text = "Hello"
		button.backgroundColor = .red
		view.addSubview(button)
		
		

	}

	
	
	
}
