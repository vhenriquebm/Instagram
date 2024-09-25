//
//  ProfileCollectionViewCellViewModel.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 25/09/24.
//

import Foundation

struct ProfileCollectionViewCellViewModel {
    private var post: PostList
    
    init(post: PostList) {
        self.post = post
    }
    
    var getImage: URL? {
        let url = URL(string: self.post.imageUrl)
        return url
    }
}
