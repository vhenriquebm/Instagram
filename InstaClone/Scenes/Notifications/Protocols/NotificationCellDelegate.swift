//
//  NotificationCellDelegate.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 12/04/25.
//

import Foundation

protocol NotificationCellDelegate: AnyObject {
    func cell(_ cell: NotificationsTableViewCell, wantsToFollow uid: String)
    func cell(_ cell: NotificationsTableViewCell, wantsToUnFollow uid: String)
    func cell(_ cell: NotificationsTableViewCell, wantsToViewPost uid: String)
}
