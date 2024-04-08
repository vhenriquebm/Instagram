//
//  UserSession.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 08/04/24.
//

import Foundation
import Firebase

class UserSession {
    
    static var shared = UserSession()
    
    private init() {}
    
    func isUserAuthenticated() -> Bool {
        return Auth.auth().currentUser != nil
    }
}
