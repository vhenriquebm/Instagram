//
//  NotificationServiceProtocol.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 06/10/24.
//

import Foundation

protocol NotificationServiceProtocol {
    func uploadNotification(type: NotificationType, post: PostList?, user: User)
    func getNotifications(completion: @escaping([Notification]) -> Void)
}
