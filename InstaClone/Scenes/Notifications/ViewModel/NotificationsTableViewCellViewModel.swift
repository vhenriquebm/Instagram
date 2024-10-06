//
//  NotificationsTableViewCellViewModel.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 06/10/24.
//

import Foundation
import UIKit

class NotificationsTableViewCellViewModel {
    private var notification: Notification
    
    init(notification: Notification) {
        self.notification = notification
    }
    
    var profileImageUrl: URL? {
        return URL(string: notification.userProfileImageUrl)
    }
    
    var message: NSAttributedString {
        let userName = notification.userName
        let message = notification.type.message
        
        let attributedText = NSMutableAttributedString(string: userName, attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: message, attributes: [.font: UIFont.systemFont(ofSize: 14)]))
        attributedText.append(NSAttributedString(string: " 2m", attributes: [.font: UIFont.systemFont(ofSize: 12), .foregroundColor: UIColor.lightGray]))
        return attributedText
    }
    
    var postImageView: URL? {
        return URL(string: notification.postImageUrl)
    }
}
