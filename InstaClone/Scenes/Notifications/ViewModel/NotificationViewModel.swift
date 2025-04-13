//
//  NotificationViewModel.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 06/10/24.
//

import Foundation

class NotificationViewModel: NotificationViewModelProtocol {
    private var service: NotificationServiceProtocol
    private var profileService: ProfileService
    var notifications = [Notification]()
    
    init(service: NotificationServiceProtocol, profileService: ProfileService) {
        self.service = service
        self.profileService = profileService
    }
    
    func getNotifications(completion: @escaping() -> (Void)) {
        self.service.getNotifications { notifications in
            self.notifications = notifications
            completion()
            self.checkIfUserIsFollwed()
        }
    }
    
    func checkIfUserIsFollwed() {
        notifications.forEach { notification in
            
            guard notification.type == .follow else { return }
            
            profileService.checkIfUserIsFollowed(uid: notification.uid) { isFollowed in
                if let index = self.notifications.firstIndex(where: { $0.id == notification.id }) {
                    self.notifications[index].userIsFollowed = isFollowed
                }
            }
        }
    }
}
