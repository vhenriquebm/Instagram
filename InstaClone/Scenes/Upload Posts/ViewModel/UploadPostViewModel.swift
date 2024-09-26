//
//  UploadPostViewModel.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 11/09/24.
//

import UIKit

class UploadPostViewModel: UploadPostViewModelProtocol {
    private var service: PostServiceProtocol
    var user: User?
    
    init(service: PostServiceProtocol, user: User?) {
        self.service = service
        self.user = user
    }
    
    var getUser: User? {
        return self.user
    }
    
    func upload(post: Post, completion: @escaping FirestoreCompletion) {
        guard let user = self.getUser else { return }
        service.upload(post: post, user: user, completion: completion)
    }
    
    func checkMaxLength(_ textView: UITextView) {
        if (textView.text.count) > 100 {
            textView.deleteBackward()
        }
    }
}
