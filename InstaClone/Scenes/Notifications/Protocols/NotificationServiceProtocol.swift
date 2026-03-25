//
//  NotificationServiceProtocol.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 06/10/24.
//

import Foundation

protocol NotificationServiceProtocol {
    func uploadNotification(to uid: String, from user: User, type: NotificationType, post: PostList?)
    func getNotifications(completion: @escaping ([Notification]) -> Void)
}
