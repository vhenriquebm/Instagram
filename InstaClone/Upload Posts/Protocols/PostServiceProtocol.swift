//
//  PostServiceProtocol.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 11/09/24.
//

import Foundation

protocol PostServiceProtocol {
    func upload(post: Post, completion: @escaping(FirestoreCompletion))
}
