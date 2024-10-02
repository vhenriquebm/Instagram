//
//  FeedViewModel.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 28/03/24.
//

import Foundation

class FeedViewModel: FeedViewModelProtocol {
    private var service: FeedServiceProtocol
    private var userService: UserServiceProtocol
    var postList = [PostList]()
    var post: PostList?
    
    init(service: FeedServiceProtocol, userService: UserServiceProtocol, post: PostList? = nil ) {
        self.service = service
        self.userService = userService
        self.post = post
    }
    
    func getPosts(completion: @escaping () -> ()) {
        guard post == nil else { return }
        
        self.service.getPosts { posts in
            self.postList = posts
            
            self.checkIfUserLikedPost(completion: completion)
        }
    }
    
    private func checkIfUserLikedPost(completion: @escaping () -> ()) {
        self.postList.forEach { post in
            
            service.checkIfUserLikedPost(post: post) { didLike in
                if let index = self.postList.firstIndex(where: { $0.postId == post.postId }) {
                    self.postList[index].didLike = didLike
                }
                
                completion()
            }
        }
    }
    
    func didTapLike(post: PostList, completion: @escaping (Bool) -> ()) {
        guard let didLike = post.didLike else { return }
        
        if didLike {
            self.service.unLike(post: post) { error in
                guard error == nil else { return }
                completion(false)
            }
        } else {
            self.service.like(post: post) { error in
                guard error == nil else { return }
                completion(true)
            }
        }
    }
    
    func getUser(with uid: String,  completion: @escaping profileCompletion) {
        self.userService.getUser(with: uid, completion: completion)
    }
}


