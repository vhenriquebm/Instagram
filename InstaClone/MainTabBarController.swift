//
//  MainTabBarController.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 26/03/24.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setControllers()
        self.tabBar.backgroundColor = .red
    }
    
    
    private func setControllers() {
        let viewController = ViewController()
        viewController.tabBarItem.image = UIImage(named: "person")
        let controllers = [viewController]
        self.setViewControllers(controllers, animated: false)
        
    }
}
