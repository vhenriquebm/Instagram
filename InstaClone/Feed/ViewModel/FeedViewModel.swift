//
//  FeedViewModel.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 28/03/24.
//

import Foundation

class FeedViewModel: FeedViewModelProtocol {
    private var service: FeedServiceProtocol
    var posts = [PostList]()
    
    init(service: FeedServiceProtocol) {
        self.service = service
    }
    
    func getPosts(completion: @escaping () -> ()) {
        self.service.getPosts { posts in
            self.posts = posts
            completion()
            print ("The posts are \(posts)")
        }
    }
}


