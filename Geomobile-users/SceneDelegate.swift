//
//  SceneDelegate.swift
//  Geomobile-users
//
//  Created by Karol Majka on 22/11/2023.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    private var appCoordinator: AppCoordinator!

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.windowScene = windowScene
        self.window = window

        appCoordinator = AppCoordinator(dependencies: .init(presentation: .window(window: window, transition: nil)))
        appCoordinator.start()
    }
}
