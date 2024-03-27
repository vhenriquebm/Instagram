//
//  LoginViewModelProtocol.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 27/03/24.
//

import Foundation

protocol LoginViewModelProtocol {
    var email: String? { get set }
    var password: String? { get set }
    var isValid: Bool { get }
}
