//
//  FeedService.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 20/09/24.
//

import Foundation

class FeedService: FeedServiceProtocol {
    
    func getPosts(completion: @escaping ([PostList])->()) {
        COLLECTION_POSTS.order(by: "timestamp", descending: true).getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else { return }
            
            let posts = documents.map { PostList(postId: $0.documentID,
                                                 dictionary: $0.data())}
            
            completion(posts)
        }
    }
}
