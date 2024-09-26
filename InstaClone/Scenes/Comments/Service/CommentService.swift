//
//  CommentService.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 26/09/24.
//

import Firebase

struct CommentService {
    func uploadComment(comment: String, postId: String, user: User, completion: @escaping(FirestoreCompletion)) {
        
        let data: [String: Any] = ["uid": user.uid,
                                   "comment": comment,
                                   "timestamp": Timestamp(date: Date()),
                                   "username": user.username,
                                   "profileImageUrl": user.profileImageUrl ]
        
        COLLECTION_POSTS.document(postId).collection("comments").addDocument(data: data, completion: completion)
    }
}
