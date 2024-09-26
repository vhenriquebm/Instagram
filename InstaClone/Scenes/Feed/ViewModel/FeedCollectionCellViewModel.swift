//
//  FeedCollectionCellViewModel.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 21/09/24.
//

import Foundation

struct FeedCollectionCellViewModel {
    let post: PostList
    
    init(post: PostList) {
        self.post = post
        
        print ("DEBUG - NA CELULA O POST E \(post)")
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
    
    var caption: String {
        return post.caption
    }
}
