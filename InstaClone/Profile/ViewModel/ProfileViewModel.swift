//
//  ProfileViewModel.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 29/03/24.
//

import Foundation

struct ProfileViewModel: ProfileViewModelProtocol {
    public func getUser(completion: @escaping profileCompletion) {
        ProfileService.getUser(completion: completion)
    }
}
