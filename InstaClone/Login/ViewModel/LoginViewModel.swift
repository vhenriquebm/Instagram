//
//  LoginViewModel.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 27/03/24.
//

import Foundation

class LoginViewModel: LoginViewModelProtocol {
    private var coordinator: LoginCoordinatorProtocol
    public var email: String?
    public var password: String?
    
    required init (coordinator: LoginCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    var isValid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false
    }
    
    func login(with email: String, and password: String, completion: @escaping loginCompletion) {
        LoginService.login(with: email, and: password, completion: completion)
    }
    
    func goToFeed() {
        coordinator.goToFeed()
    }
}
