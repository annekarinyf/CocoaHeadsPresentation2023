//
//  AppDelegate.swift
//  CocoaPresentation
//
//  Created by Anne Freitas on 30/10/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        window?.rootViewController = UINavigationController(rootViewController: ViewController(storage: InMemoryStorage()))
        window?.makeKeyAndVisible()
    
        return true
    }
}
