//
//  SearchViewModel.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 11/04/24.
//

import UIKit

class SearchViewModel: SearchViewModelProtocol {
    
    func getUsers(completion: @escaping usersCompletion) {
        ProfileService.getUsers(completion: completion)
    }
    
    func goToProfile(user: User, navigation: UINavigationController) {
        let coordinator = ProfileCoordinator(navigation: navigation,
                                             user: user)
        
        coordinator.start()
    }
}
