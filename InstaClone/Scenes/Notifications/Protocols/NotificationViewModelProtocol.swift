//
//  NotificationViewModelProtocol.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 06/10/24.
//

import Foundation

protocol NotificationViewModelProtocol {
    func getNotifications(completion: @escaping() -> (Void))
    func getPost(with uuid: String)
    func follow(with uid: String, completion: @escaping FirestoreCompletion)
    func unFollow(with uid: String, completion: @escaping FirestoreCompletion)
    func getUser(with uid: String)
    
    var notifications: [Notification] { get }
}
