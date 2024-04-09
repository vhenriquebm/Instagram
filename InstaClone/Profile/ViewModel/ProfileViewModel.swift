//
//  ProfileViewModel.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 29/03/24.
//

import Foundation

class ProfileViewModel: ProfileViewModelProtocol {
    private var user: User
    
    required init(user: User) {
        self.user = user
    }
    
    var getUser: User {
        return user
    }
}
