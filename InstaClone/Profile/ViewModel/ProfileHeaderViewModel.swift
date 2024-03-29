//
//  ProfileViewModel.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 29/03/24.
//

import Foundation

class ProfileHeaderViewModel: ProfileHeaderViewModelProtocol {
    private var user: User
    
    init(user: User) {
        self.user = user
    }
    
    var userName: String {
        return user.username
    }
    
    var profileImageUrl: URL? {
        let url = URL(string: user.profileImageUrl)  
        return url
    }
}
