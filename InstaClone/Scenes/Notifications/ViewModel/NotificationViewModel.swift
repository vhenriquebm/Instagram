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
    private var coordinator: NotificationsCoordinatorProtocol
    var notifications = [Notification]()
    
    init(service: NotificationServiceProtocol, profileService: ProfileService, coordinator: NotificationsCoordinatorProtocol) {
        self.service = service
        self.profileService = profileService
        self.coordinator = coordinator
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
    
    func getPost(with uuid: String) {
        profileService.getPost(with: uuid) { post in
            DispatchQueue.main.async {
                self.coordinator.navigateTo(post: post)
            }
        }
    }
    
    func follow(with uid: String, completion: @escaping FirestoreCompletion) {
        self.profileService.follow(uid: uid, completion: completion)
    }
    
    func unFollow(with uid: String, completion: @escaping FirestoreCompletion) {
        self.profileService.unfollow(uid: uid, completion: completion)
    }
    
    func getUser(with uid: String) {
        ProfileService.getUser { user in
            guard let user = user else { return }
            
            DispatchQueue.main.async {
                self.coordinator.navigateToProfile(with: user)
            }
        }
    }
}
