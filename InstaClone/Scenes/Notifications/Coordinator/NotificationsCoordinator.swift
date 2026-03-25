//
//  NotificationsCoordinator.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 23/04/25.
//

import UIKit

protocol NotificationsCoordinatorProtocol {
    func navigateTo(post: PostList)
    func navigateToProfile(with user: User)
}

class NotificationsCoordinator: Coordinator {
    var navigation: UINavigationController
    var window: UIWindow?
    var currentController: UIViewController?

    init(navigation: UINavigationController, window: UIWindow? = nil) {
        self.navigation = navigation
        self.window = window
    }

    func start() {
        let controller = LoginViewController()
        // let viewModel = LoginViewModel(coordinator: self)
        //  window?.rootViewController = controller
        //  window?.makeKeyAndVisible()
        // controller.delegate =  viewModel
        // navigation.modalPresentationStyle = .fullScreen
        // navigation.present(controller, animated: true)
        // currentController = controller
    }
}

// MARK: - Navigate to Post

extension NotificationsCoordinator: NotificationsCoordinatorProtocol {
    func navigateTo(post: PostList) {
        let layout = UICollectionViewFlowLayout()
        let controller = FeedViewController(collectionViewLayout: layout)

        let viewModel = FeedViewModel(service: FeedService(),
                                      userService: UserService(),
                                      notificationService: NotificationService(),
                                      post: nil)
        viewModel.post = post

        controller.viewModel = viewModel

        self.navigation.pushViewController(controller, animated: false)
    }
}

// MARK: - Open User Profile

extension NotificationsCoordinator {
    func navigateToProfile(with user: User) {

        let controller = ProfileViewController()

        let viewModel = ProfileViewModel(user: user)

        controller.viewModel = viewModel

        self.navigation.pushViewController(controller, animated: false)
    }
}
