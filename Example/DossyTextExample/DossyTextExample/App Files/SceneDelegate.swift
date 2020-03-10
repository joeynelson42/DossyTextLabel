//
//  SceneDelegate.swift
//  DossyTextExample
//
//  Created by Joey Nelson on 3/10/20.
//  Copyright © 2020 nelsonje. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let root = ViewController()
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = root
        window?.makeKeyAndVisible()
    }
}

