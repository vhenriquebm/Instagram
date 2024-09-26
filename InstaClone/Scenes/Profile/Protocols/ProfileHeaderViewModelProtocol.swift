//
//  ProfileHeaderViewModelProtocol.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 29/03/24.
//

import Foundation

protocol ProfileHeaderViewModelProtocol {
    var userName: String { get }
    var profileImageUrl: URL? { get }
}
