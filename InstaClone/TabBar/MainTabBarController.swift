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
        let layout = UICollectionViewFlowLayout()
        
        let feed = createController(unselectedImage: .homeUnselected,
                                    selectedImage: .homeSelected,
                                    rootViewController: FeedViewController(collectionViewLayout: layout))
        
        let search = createController(unselectedImage: .searchSelected,
                                      selectedImage: .searchUnselected,
                                      rootViewController: SearchViewController())
        
        let imageSelector = createController(unselectedImage: .plusUnselected,
                                             selectedImage: .plusPhoto,
                                             rootViewController: ImageSelectorViewController())
        
        let notification = createController(unselectedImage: .likeUnselected,
                                            selectedImage: .likeSelected,
                                            rootViewController: NotificationViewController())
        
        let profileLayout = UICollectionViewFlowLayout()
        let profile = createController(unselectedImage: .profileUnselected,
                                       selectedImage: .profileSelected,
                                       rootViewController: ProfileViewController(collectionViewLayout: profileLayout))
        
        viewControllers = [feed, search, imageSelector, notification, profile]
        
    }
    
    private func createController(unselectedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController) -> UINavigationController {
        let navigation = UINavigationController(rootViewController: rootViewController)
        navigation.tabBarItem.image = unselectedImage
        navigation.tabBarItem.selectedImage = selectedImage
        navigation.navigationBar.tintColor = .black
        return navigation
    }
}
