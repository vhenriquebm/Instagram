//
//  User.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 29/03/24.
//

import Foundation
import Firebase

struct User {
    let email: String
    let uid: String
    let username: String
    let profileImageUrl: String
    let fullname: String
    
    var isFollewed: Bool = false
    
    var isCurrentUser: Bool {return Auth.auth().currentUser?.uid == uid}
    
    init(dictionary: [String : Any]) {
        self.email = dictionary["email"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        self.fullname = dictionary["fullname"] as? String ?? ""
    }
}

