//
//  AppDelegate.swift
//  Geomobile-users
//
//  Created by Karol Majka on 22/11/2023.
//

import UIKit
import Kingfisher

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // do not use cache
        ImageCache.default.memoryStorage.config.countLimit = 100
        ImageCache.default.diskStorage.config.expiration = .expired

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}
