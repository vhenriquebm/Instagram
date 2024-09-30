//
//  UserService.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 30/09/24.
//

import Foundation
import FirebaseAuth

class UserService: UserServiceProtocol {
    
    func getUser(with uid: String, completion: @escaping profileCompletion) {
        COLLECTION_USERS.document(uid).getDocument { snapshot, error in
            
            guard let dictionary = snapshot?.data() else { return }
            let user = User(dictionary: dictionary)
            completion(user)
        }
    }
}
