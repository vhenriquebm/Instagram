//
//  CommentViewModelProtocol.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 26/09/24.
//

import Foundation

protocol CommentViewModelProtocol {
    func uploadComment(comment: String, completion: @escaping () -> ())
    func getComments(completion: @escaping () -> ())
    func getUser(with uid: String)
    
    var comments: [Comment] { get set }
}
