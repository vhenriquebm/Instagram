//
//  MainTabBarController.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 26/03/24.
//

import UIKit

class MainTabBarController: UITabBarController {
    private var user: User?
    var viewModel: MainTabBarViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.backgroundColor = .white
        self.tabBar.tintColor = .black
        self.viewModel = MainTabBarViewModel()
        getUser()
    }
    
    private func getUser() {
        viewModel?.getUser(completion: { user in
            self.user = user
            self.setControllers()
        })
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
        
        
        let controller = ProfileViewController(collectionViewLayout: profileLayout)
        let viewModel = ProfileViewModel(user: user!)
        controller.viewModel = viewModel
        let profile = createController(unselectedImage: .profileUnselected,
                                       selectedImage: .profileSelected,
                                       rootViewController: controller)
        
        
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
