//
//  UploadPostViewModel.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 11/09/24.
//

import UIKit

class UploadPostViewModel: UploadPostViewModelProtocol {
    private var service: PostServiceProtocol
    
    init(service: PostServiceProtocol) {
        self.service = service
    }
    
    func upload(post: Post, completion: @escaping FirestoreCompletion) {
        service.upload(post: post, completion: completion)        
    }
    
    func checkMaxLength(_ textView: UITextView) {
        if (textView.text.count) > 100 {
            textView.deleteBackward()
        }
    }
}
