//
//  CommentCellViewModel.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 26/09/24.
//

import UIKit

struct CommentCellViewModel {
    let comment: Comment
    
    init(comment: Comment) {
        self.comment = comment
    }
    
    var getImage: URL? {
        return URL(string: self.comment.profileImageUrl)
    }
    
    func commentLabelText() -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: "\(self.comment.username)  ", attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        attributedString.append(NSAttributedString(string: self.comment.comment, attributes: [.font: UIFont.systemFont(ofSize: 14)]))
        
        return attributedString
    }
}
