//
//  FeedCellDelegate.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 26/09/24.
//

import Foundation

protocol FeedCellDelegate: AnyObject {
    func cell(_ cell: FeedCollectionViewCell, wantsToShowCommentsFor post: PostList)
    func cell(_ cell: FeedCollectionViewCell, didLike post: PostList)
    func cell(_ cell: FeedCollectionViewCell, wantsToShowProfileFor uid: String)
}
