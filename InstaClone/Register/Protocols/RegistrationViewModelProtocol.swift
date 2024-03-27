//
//  RegistrationViewModelProtocol.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 27/03/24.
//

import Foundation

protocol RegistrationViewModelProtocol {
    var email: String? { get set }
    var password: String? { get set }
    var fullName: String? { get set }
    var userName: String? { get set }
    var isValid: Bool { get }
}
