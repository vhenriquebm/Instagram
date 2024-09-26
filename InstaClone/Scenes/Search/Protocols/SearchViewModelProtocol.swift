//
//  SearchViewModelProtocol.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 11/04/24.
//

import UIKit

protocol SearchViewModelProtocol: AnyObject {
    func getUsers(completion: @escaping usersCompletion)
    func goToProfile(user: User, navigation: UINavigationController)
}
