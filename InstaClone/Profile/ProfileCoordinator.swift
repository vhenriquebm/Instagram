//
//  SearchCoordinator.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 22/04/24.
//

import UIKit

class ProfileCoordinator: Coordinator {
    var navigation: UINavigationController
    private var user: User
    
    init(navigation: UINavigationController, user: User) {
        self.navigation = navigation
        self.user = user
    }
    
    func start() {
        let layout = UICollectionViewFlowLayout()
        let controller = ProfileViewController(collectionViewLayout: layout)
        controller.viewModel = ProfileViewModel(user: user)
        controller.modalPresentationStyle = .fullScreen
        navigation.pushViewController(controller, animated: false)
    }
}


