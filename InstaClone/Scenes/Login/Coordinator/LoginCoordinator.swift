//
//  LoginCoordinator.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 02/04/24.
//

import UIKit

class LoginCoordinator: Coordinator {
    var navigation: UINavigationController
    var window: UIWindow?
    var currentController: UIViewController?
    
    init(navigation: UINavigationController, window: UIWindow? = nil) {
        self.navigation = navigation
        self.window = window
    }
    
    func start() {
        let controller = LoginViewController()
        let viewModel = LoginViewModel(coordinator: self)
        window?.rootViewController = controller
        window?.makeKeyAndVisible()
        controller.delegate =  viewModel
        navigation.modalPresentationStyle = .fullScreen
        navigation.present(controller, animated: true)
        currentController = controller
    }
}

extension LoginCoordinator: LoginCoordinatorProtocol {
    func goToFeed() {
        let controller = MainTabBarController()
        let navigation = UINavigationController(rootViewController: controller)
        navigation.modalPresentationStyle = .fullScreen
        currentController?.present(navigation, animated: true)
    }
}
