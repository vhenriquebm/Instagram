//
//  MainTabBarController.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 26/03/24.
//

import UIKit
import YPImagePicker

class MainTabBarController: UITabBarController {
    var user: User?
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
        self.delegate = self
        
        let layout = UICollectionViewFlowLayout()
        
        let feedContoller = FeedViewController(collectionViewLayout: layout)
        feedContoller.viewModel = FeedViewModel(service: FeedService(), 
                                                userService: UserService())
    
        let feed = createController(unselectedImage: .homeUnselected,
                                    selectedImage: .homeSelected,
                                    rootViewController: feedContoller)
        
        let search = createController(unselectedImage: .searchSelected,
                                      selectedImage: .searchUnselected,
                                      rootViewController: createSearchController())
        
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
        
        let tabBarItemSize = CGSize(width: 25, height: 25)
        let resizedUnselectedImage = unselectedImage.resized(to: tabBarItemSize)
        let resizedSelectedImage = selectedImage.resized(to: tabBarItemSize)
        
        navigation.tabBarItem.image = resizedUnselectedImage
        navigation.tabBarItem.selectedImage = resizedSelectedImage
        navigation.navigationBar.tintColor = .black
        
        return navigation
    }
    
    private func didFinishPickingMedia(_ picker: YPImagePicker) {
        picker.didFinishPicking { items, cancelled in
            picker.dismiss(animated: false) {
                guard let selectedImage = items.singlePhoto?.image else { return }
                
                let controller = UploadPostViewController()
                let viewModel = UploadPostViewModel(service: PostService(), user: self.user)
                
                controller.selectedImage = selectedImage
                controller.viewModel = viewModel
                controller.delegate = self
                
                let navigation =  UINavigationController(rootViewController: controller)
                navigation.modalPresentationStyle = .fullScreen
                self.present(navigation, animated: false)
            }
        }
    }
}

extension MainTabBarController {
    
    func createSearchController() -> SearchViewController {
        let controller = SearchViewController()
        let viewModel = SearchViewModel()
        controller.viewModel = viewModel
        return controller
    }
}

//MARK: - UITabBarControllerDelegate

extension MainTabBarController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let index = viewControllers?.firstIndex(of: viewController)
        
        if index == 2 {
            var pickerConfiguration = YPImagePickerConfiguration()
            pickerConfiguration.library.mediaType = .photo
            pickerConfiguration.shouldSaveNewPicturesToAlbum = false
            pickerConfiguration.startOnScreen = .library
            pickerConfiguration.screens = [.library]
            pickerConfiguration.hidesStatusBar = false
            pickerConfiguration.hidesBottomBar = false
            pickerConfiguration.library.maxNumberOfItems = 1
            
            let picker = YPImagePicker(configuration: pickerConfiguration)
            picker.modalPresentationStyle = .fullScreen
            present(picker, animated: true, completion: nil)
            
            didFinishPickingMedia(picker)
        }
        
        return true
    }
}

//MARK: - UploadPostDelegate

extension MainTabBarController: UploadPostDelegate {
    
    func didFinishUploadingPost(_ controller: UploadPostViewController) {
        selectedIndex = 0
        controller.dismiss(animated: true)
        
        guard let feedNavigation = viewControllers?.first as? UINavigationController,
              let feed = feedNavigation.viewControllers.first as? FeedViewController else { return}
        
        feed.refresh()
    }
}
