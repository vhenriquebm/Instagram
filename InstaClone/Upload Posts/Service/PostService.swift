//
//  PostService.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 11/09/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

struct PostService: PostServiceProtocol {
    func upload(post: Post, completion: @escaping (FirestoreCompletion)) {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        ImageUploader.uploadImage(image: post.image) { imageUrl in
            
            let data = ["caption": post.caption,
                        "timestamp": Timestamp(date: Date()),
                        "likes": 0,
                        "imageUrl": imageUrl,
                        "ownerUid": uid ]
            
            
            COLLECTION_POSTS.addDocument(data: data, completion: completion)
            
        }
    }
}
