//
//  Notification.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 06/10/24.
//

import Foundation
import Firebase

enum NotificationType: Int {
    case like
    case follow
    case comment
    
    var message: String {
        switch self {
        case .like: return " liked your post."
        case .follow: return " started following you"
        case .comment: return " commented on your post"
        }
    }
}

struct Notification {
    let uid: String
    var postImageUrl: String
    var postId: String
    let timestamp: Timestamp
    let type: NotificationType
    let id: String
    
    init(dictionary: [String: Any]) {
        self.uid = dictionary["uid"] as? String ?? ""
        self.postImageUrl = dictionary["postImageUrl"] as? String ?? ""
        self.postId = dictionary["postId"] as? String ?? ""
        self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
        self.type = NotificationType(rawValue: dictionary["type"] as? Int ?? 0) ?? .like
        self.id = dictionary["id"] as? String ?? ""
    }
}
