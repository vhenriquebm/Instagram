//
//  FeedCollectionCellViewModel.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 21/09/24.
//

import Foundation

struct FeedCollectionCellViewModel {
    private let post: PostList
    
    init(post: PostList) {
        self.post = post
    }
    
    var imageUrl: URL? {
        return URL(string: post.imageUrl)
    }
    
    var likes: Int {
        return post.likes
    }
    
    var caption: String {
        return post.caption
    }
}
