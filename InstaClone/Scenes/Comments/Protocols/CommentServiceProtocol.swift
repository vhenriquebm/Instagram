//
//  CommentServiceProtocol.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 26/09/24.
//

import Foundation

protocol CommentServiceProtocol {
    func uploadComment(comment: String, postId: String, user: User, completion: @escaping(FirestoreCompletion))
    
    func getComments(post postID: String, completion: @escaping([Comment]) -> Void)
}
