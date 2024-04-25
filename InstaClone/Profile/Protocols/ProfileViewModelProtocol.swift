//
//  ProfileViewModelProtocol.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 29/03/24.
//

import Foundation

protocol ProfileViewModelProtocol {
    var getUser: User { get }
    
    func follow(uuid: String, completion: @escaping FirestoreCompletion)
    func unfollow(uuid: String, completion: @escaping FirestoreCompletion)
    func checkIfUserIsFollowed(uid: String, completion: @escaping(Bool) -> Void)
    func getUserStats(uid: String, completion: @escaping UserStatsCompletion)
}
