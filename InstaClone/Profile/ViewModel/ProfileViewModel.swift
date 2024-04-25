//
//  ProfileViewModel.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 29/03/24.
//

import Foundation

class ProfileViewModel: ProfileViewModelProtocol {
    private var user: User
    private var service: ProfileService
    
    required init(user: User) {
        self.user = user
        self.service = ProfileService()
        
        print ("DEBUG - USER - \(user)")
    }
    
    var getUser: User {
        return user
    }
    
    func follow(uuid: String, completion: @escaping FirestoreCompletion) {
        service.follow(uid: uuid, completion: completion)
    }
    
    func unfollow(uuid: String, completion: @escaping FirestoreCompletion) {
        service.unfollow(uid: uuid, completion: completion)
    }
    
    func checkIfUserIsFollowed(uid: String, completion: @escaping(Bool) -> Void) {
        service.checkIfUserIsFollowed(uid: uid, completion: completion)
    }
    
    func getUserStats(uid: String, completion: @escaping UserStatsCompletion) {
        service.getUserStats(uid: uid, completion: completion)
    }
}
