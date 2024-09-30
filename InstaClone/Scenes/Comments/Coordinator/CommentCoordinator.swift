//
//  CommentCoordinator.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 30/09/24.
//

import UIKit


class CommentCoordinator: Coordinator {
    var navigation: UINavigationController
    
    private var post: PostList
    private var user: User
    
    init(navigation: UINavigationController, post: PostList, user: User) {
        self.navigation = navigation
        self.post = post
        self.user = user
    }
    
    func start() {
        let controller = CommentViewController(collectionViewLayout: UICollectionViewFlowLayout())
        
        let viewModel = CommentViewModel(service: CommentService(),
                                         userService: UserService(), 
                                         coordinator: self,
                                         post: post, user: user)
        
        controller.viewModel = viewModel
        
        navigation.pushViewController(controller, animated: true)
    }
}

//MARK: - CommentCoordinatorProtocol

extension CommentCoordinator: CommentCoordinatorProtocol {
    
    func goToProfile(with user: User) {
        
        let coordinator = ProfileCoordinator(navigation: navigation, user: user)
        coordinator.start()
    }
}
