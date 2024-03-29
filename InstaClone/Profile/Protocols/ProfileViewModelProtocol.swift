//
//  ProfileViewModelProtocol.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 29/03/24.
//

import Foundation

protocol ProfileViewModelProtocol {
    func getUser(completion: @escaping profileCompletion)
}
