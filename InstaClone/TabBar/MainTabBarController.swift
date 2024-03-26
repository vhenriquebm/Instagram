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
        self.tabBar.backgroundColor = .white
        self.tabBar.tintColor = .black
    }
    
    
    private func setControllers() {
        
        let feed = createController(unselectedImage: "home_unselected",
                                    selectedImage: "home_selected",
                                    rootViewController: FeedViewController())
        
        let search = createController(unselectedImage: "search_selected",
                                      selectedImage: "search_unselected",
                                      rootViewController: SearchViewController())
        
        let imageSelector = createController(unselectedImage: "plus_unselected",
                                             selectedImage: "plus_photo",
                                             rootViewController: ImageSelectorViewController())
        
        let notification = createController(unselectedImage: "like_unselected",
                                            selectedImage: "like_selected",
                                            rootViewController: NotificationViewController())
        
        let profile = createController(unselectedImage: "profile_unselected",
                                       selectedImage: "profile_selected",
                                       rootViewController: ProfileViewController())
        
        viewControllers = [feed, search, imageSelector, notification, profile]
        
    }
    
    
    private func createController(unselectedImage: String, selectedImage: String, rootViewController: UIViewController) -> UINavigationController {
        let navigation = UINavigationController(rootViewController: rootViewController)
        navigation.tabBarItem.image = UIImage(named: unselectedImage)
        navigation.tabBarItem.selectedImage = UIImage(named: selectedImage)
        navigation.navigationBar.tintColor = .black
        return navigation
    }
}
