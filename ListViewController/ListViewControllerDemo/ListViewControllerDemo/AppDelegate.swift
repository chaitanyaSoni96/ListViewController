//
//  AppDelegate.swift
//  ListViewControllerDemo
//
//  Created by Chaitanya Soni on 19/04/21.
//

import UIKit
import ListViewController

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let examplesViewController = ExamplesViewController.instantiate()
        let navigationController = UINavigationController(rootViewController: examplesViewController)
        let window = UIWindow()
        window.rootViewController = navigationController
        self.window = window
        self.window?.makeKeyAndVisible()
        
        return true
    }


}

