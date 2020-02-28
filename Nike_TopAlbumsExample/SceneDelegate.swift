//
//  SceneDelegate.swift
//  Nike_TopAlbumsExample
//
//  Created by Brian Schick on 2/25/20.
//  Copyright © 2020 Brian Schick. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = (scene as? UIWindowScene) else { return }
		
		let mainViewController = MainViewController()
		
		window = UIWindow(frame: UIScreen.main.bounds)
		window?.rootViewController = mainViewController
		window?.makeKeyAndVisible()
		window?.windowScene = windowScene
		
//		FeedData.mock(for: mainViewController)
		RSSAlbumsService.inject(into: mainViewController)
	}

	func sceneDidDisconnect(_ scene: UIScene) { }

	func sceneDidBecomeActive(_ scene: UIScene) { }

	func sceneWillResignActive(_ scene: UIScene) { }

	func sceneWillEnterForeground(_ scene: UIScene) { }

	func sceneDidEnterBackground(_ scene: UIScene) { }
}
