//
//  SceneDelegate.swift
//  CocoaPresentation
//
//  Created by Anne Freitas on 30/10/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = UINavigationController(rootViewController: ViewController(storage: InMemoryStorage()))
        self.window = window
        window.makeKeyAndVisible()
    }
}
