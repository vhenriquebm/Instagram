//
//  UserServiceProtocol.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 30/09/24.
//

import Foundation

protocol UserServiceProtocol {
    func getUser(with uid: String, completion: @escaping profileCompletion)
}
