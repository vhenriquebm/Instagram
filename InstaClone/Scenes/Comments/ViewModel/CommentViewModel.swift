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
    private var notificationService: NotificationService
    private var coordinator: CommentCoordinatorProtocol
    private var post: PostList
    private var user: User
    var comments = [Comment]()

    init(service: CommentServiceProtocol, userService: UserServiceProtocol, notificationService: NotificationService, coordinator: CommentCoordinatorProtocol, post: PostList, user: User) {
        self.service = service
        self.userService = userService
        self.notificationService = notificationService
        self.coordinator = coordinator
        self.post = post
        self.user = user
    }

    func uploadComment(comment: String, completion: @escaping () -> Void) {
        self.service.uploadComment(comment: comment, postId: post.postId, user: user, completion: {_ in
            completion()
        })
    }

    func getComments(completion: @escaping () -> Void) {
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

    func uploadNotification(from user: User, type: NotificationType) {

        notificationService.uploadNotification(to: post.ownerUid,
                                               from: user,
                                               type: type,
                                               post: post)
    }
}
