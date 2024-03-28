//
//  RegistrationService.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 27/03/24.
//

import Foundation
import Firebase

typealias registrationCompletion = (Error?) -> ()

class RegistrationService {
    
    static func register(with user: UserRegistration, completion: @escaping registrationCompletion ) {
        
        ImageUploader.uploadImage(image: user.profileImage!) { imageUrl in
            
            Auth.auth().createUser(withEmail:  user.email, password: user.password) { result, error in
                
                if let error = error {
                    print ("DEBUG: Failed to register user \(error.localizedDescription)")
                    return
                } else {
                    print ("DEBUG: Success to register user")

                }
                
                guard let uid = result?.user.uid else { return }
                
                let data: [String: Any] = ["email": user.email,
                                           "fullname": user.fullName,
                                           "profileImageUrl": imageUrl,
                                           "uid": uid,
                                           "username": user.userName.lowercased() ]
                
                print ("DEBUG: Data to firesote \(data)")

                Firestore.firestore().collection("users").document(uid).setData(data, completion: completion)
            }
        }
    }
}
