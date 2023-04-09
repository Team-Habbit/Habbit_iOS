//
//  SceneDelegate.swift
//  Habbit
//
//  Created by 김상혁 on 2023/04/07.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let initialViewController = UINavigationController(rootViewController: HomeViewController())

        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = initialViewController
        window?.makeKeyAndVisible()
    }
}

