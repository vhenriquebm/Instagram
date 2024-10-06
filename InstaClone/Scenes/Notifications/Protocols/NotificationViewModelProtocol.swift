//
//  NotificationViewModelProtocol.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 06/10/24.
//

import Foundation

protocol NotificationViewModelProtocol {
    func getNotifications(completion: @escaping() -> (Void))
    
    var notifications: [Notification] { get }
}
