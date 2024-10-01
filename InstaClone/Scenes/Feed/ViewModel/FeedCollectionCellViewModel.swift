//
//  FeedCollectionCellViewModel.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 21/09/24.
//

import Foundation

struct FeedCollectionCellViewModel {
    var post: PostList
    
    init(post: PostList) {
        self.post = post
    }
    
    var ownerImageUrl: URL? {
        return URL(string: post.ownerImageUrl)
    }
    
    var ownerUserName: String {
        return post.ownerUserName
    }
    
    var imageUrl: URL? {
        return URL(string: post.imageUrl)
    }
    
    var likes: String {
        post.likes == 1 ? "\(post.likes) like" : "\(post.likes) likes"
    }
    
    var didLike: Bool? {
        return post.didLike
    }
    
    var caption: String {
        return post.caption
    }
}
