//
//  ProfileViewModel.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 29/03/24.
//

import UIKit

class ProfileHeaderViewModel: ProfileHeaderViewModelProtocol {
    private var user: User
    
    init(user: User) {
        self.user = user
    }
    
    var getUser: User {
        return user
    }
    
    var userName: String {
        return user.username
    }
    
    var followButtonText: String {
        if  user.isCurrentUser {
            return "Edit Profile"
        }
        
        return user.isFollewed ? "Following" : "Follow"
    }
    
    var followButtonBackGroundColor: UIColor {
        return user.isCurrentUser ? .white : .systemBlue
    }
    
    var followButtonTextColor: UIColor {
        return user.isCurrentUser ? .black : .white
    }
    
    var profileImageUrl: URL? {
        let url = URL(string: user.profileImageUrl)
        return url
    }
}
