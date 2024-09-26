//
//  CommentInputAccesoryViewDelegate.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 26/09/24.
//

import Foundation

protocol CommentInputAccesoryViewDelegate: AnyObject {
    func inputView(_ inputView: CommentInputAccesoryView, wantsToUpload comment: String)
}
