//
//  MainTabBarViewModelProtocol.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 09/04/24.
//

import Foundation

protocol MainTabBarViewModelProtocol {
    func getUser(completion: @escaping profileCompletion)
}
