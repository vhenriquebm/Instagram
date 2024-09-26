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
    
    init(service: FeedServiceProtocol) {
        self.service = service
    }
    
    func getPosts(completion: @escaping () -> ()) {
        guard post == nil else { return }
        
        self.service.getPosts { posts in
            self.postList = posts
            completion()
            print ("The posts are \(posts)")
        }
    }
}


