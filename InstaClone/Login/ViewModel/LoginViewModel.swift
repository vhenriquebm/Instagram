//
//  LoginViewModel.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 27/03/24.
//

import Foundation

struct LoginViewModel: LoginViewModelProtocol {
    var email: String?
    var password: String?
    
    var isValid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false
    }
}
