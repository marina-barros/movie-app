//
//  SceneDelegate.swift
//  MovieApp
//
//  Created by Marina Barros on 16/01/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = MoviesTabBarController()
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}

