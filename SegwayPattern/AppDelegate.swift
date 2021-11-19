//
//  AppDelegate.swift
//  SegwayPattern
//
//  Created by Geektree0101 on 2021/11/18.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    self.window = UIWindow(frame: UIScreen.main.bounds)
    self.window?.makeKeyAndVisible()
    self.window?.rootViewController = FeedViewController()
    return true
  }

}

