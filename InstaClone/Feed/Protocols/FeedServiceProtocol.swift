//
//  FeedServiceProtocol.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 20/09/24.
//

import Foundation

protocol FeedServiceProtocol {
    func getPosts(completion: @escaping ([PostList])->())
}
