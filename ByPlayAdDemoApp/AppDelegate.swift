//
//  AppDelegate.swift
//  ByPlayAdDemoApp
//
//  Created by 野田直軌 on 2020/02/05.
//  Copyright © 2020 Tsumiki Inc. All rights reserved.
//

import UIKit
import ByPlayAd

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    TIBAdSettings.setBundleId(Bundle.main.bundleIdentifier)
    
    // This Setting is debug only
    TIBAdSettings.setTest(true)
    return true
  }

  // MARK: UISceneSession Lifecycle
  @available(iOS 13.0, *)
  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }
}
