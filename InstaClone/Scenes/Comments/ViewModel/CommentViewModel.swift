//
//  CommentViewModel.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 26/09/24.
//

import Foundation

class CommentViewModel: CommentViewModelProtocol {
    private var service: CommentServiceProtocol
    private var userService: UserServiceProtocol
    private var coordinator: CommentCoordinatorProtocol
    private var post: PostList
    private var user: User
    var comments = [Comment]()
    
    init(service: CommentServiceProtocol, userService: UserServiceProtocol, coordinator: CommentCoordinatorProtocol, post: PostList, user: User) {
        self.service = service
        self.userService = userService
        self.coordinator = coordinator
        self.post = post
        self.user = user
    }
    
    func uploadComment(comment: String, completion: @escaping () -> ()) {
        self.service.uploadComment(comment: comment, postId: post.postId, user: user, completion: {_ in
            completion()
        })
    }
    
    func getComments(completion: @escaping () -> ()) {
        self.service.getComments(post: post.postId) { comments in
            self.comments = comments
            completion()
        }
    }
    
    func getUser(with uid: String) {
        self.userService.getUser(with: uid) { user in
            self.coordinator.goToProfile(with: user)
        }
    }
}
