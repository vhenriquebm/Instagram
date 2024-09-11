//
//  UploadPostViewModelProtocol.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 11/09/24.
//

import UIKit

protocol UploadPostViewModelProtocol {
    func checkMaxLength(_ textView: UITextView)
    func upload(post: Post, completion: @escaping FirestoreCompletion)
}
