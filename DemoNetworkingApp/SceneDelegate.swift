//
//  SceneDelegate.swift
//  DemoNetworkingApp
//
//  Created by r.a.gazizov on 04.05.2023.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        
        let networkService = NetworkService()
        let presenter = Presenter(networkService: networkService)
        let view = ViewController(presenter: presenter)
        presenter.view = view
        window.rootViewController = view
        
        window.makeKeyAndVisible()
    }
}
