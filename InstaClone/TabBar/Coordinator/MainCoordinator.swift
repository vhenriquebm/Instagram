//
//  MainCoordinator.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 02/04/24.
//

import UIKit

class MainCoordinator: Coordinator {
    var navigation: UINavigationController
    var window: UIWindow?
    
    init(navigation: UINavigationController, window: UIWindow?) {
        self.navigation = navigation
        self.window = window
    }
    
    func start() {
        let controller = MainTabBarController()
        window?.rootViewController = controller
        window?.makeKeyAndVisible()
        navigation.present(controller, animated: true)
    }
}
