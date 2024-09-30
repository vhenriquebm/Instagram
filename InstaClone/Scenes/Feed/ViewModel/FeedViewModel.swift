//
//  FeedViewModel.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 28/03/24.
//

import Foundation

class FeedViewModel: FeedViewModelProtocol {
    private var service: FeedServiceProtocol
    var postList = [PostList]()
    var post: PostList?
    
    init(service: FeedServiceProtocol, post: PostList? = nil ) {
        self.service = service
        self.post = post
    }
    
    func getPosts(completion: @escaping () -> ()) {
        guard post == nil else { return }
        
        self.service.getPosts { posts in
            self.postList = posts
            completion()
        }
    }
    
    func like(completion: @escaping (Bool) -> ()) {
        guard let post = self.post,
              let didLike = post.didLike else { return }
        
        if didLike {
            
        } else {
            self.service.like(post: post) { error in
                guard error == nil else { return }
                completion(true)
            }
        }
    }
}


