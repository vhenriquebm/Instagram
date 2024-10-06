//
//  NotificationViewModel.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 06/10/24.
//

import Foundation

class NotificationViewModel: NotificationViewModelProtocol {
    private var service: NotificationServiceProtocol
    var notifications = [Notification]()
    
    init(service: NotificationServiceProtocol) {
        self.service = service
    }
    
    func getNotifications(completion: @escaping() -> (Void)) {
        self.service.getNotifications { notifications in
            self.notifications = notifications
            completion()
        }
    }
}
