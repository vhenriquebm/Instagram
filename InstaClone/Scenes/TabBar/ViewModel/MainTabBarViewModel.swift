//
//  MainTabBarViewModel.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 09/04/24.
//

import Foundation

class MainTabBarViewModel: MainTabBarViewModelProtocol {
    public func getUser(completion: @escaping profileCompletion) {
        ProfileService.getUser(completion: completion)
    }
}
