//
//  ProfileViewModel.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 29/03/24.
//

import UIKit

class ProfileHeaderViewModel: ProfileHeaderViewModelProtocol {
    private var user: User
    private var posts: Int
    
    
    init(user: User, posts: Int) {
        self.user = user
        self.posts = posts
    }
    
    var getUser: User {
        return user
    }
    
    var userName: String {
        return user.username
    }
    
    var followButtonText: String {
        if  user.isCurrentUser {
            return "Edit Profile"
        }
        
        return user.isFollewed ? "Following" : "Follow"
    }
    
    var followButtonBackGroundColor: UIColor {
        return user.isCurrentUser ? .white : .systemBlue
    }
    
    var followButtonTextColor: UIColor {
        return user.isCurrentUser ? .black : .white
    }
    
    var profileImageUrl: URL? {
        let url = URL(string: user.profileImageUrl)
        return url
    }
    
    var followers: NSAttributedString {
        print ("DEBUG - FOLLOWERS - \(user.userStats.followers)")
        return attributedStatText(value: user.userStats.followers, label: "followers")
    }
    
    var following: NSAttributedString {
        print ("DEBUG - FOLLOWING - \(user.userStats.following)")

        return attributedStatText(value: user.userStats.following , label: "following")
    }
    
    var postsCount: NSAttributedString {
        return attributedStatText(value: self.posts, label: "posts")
    }
    
    func attributedStatText(value: Int, label: String) -> NSAttributedString {
        let attributedText = NSMutableAttributedString(string: "\(value)\n", attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        
        attributedText.append(NSAttributedString(string: label, attributes: [.font: UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.lightGray]))
        
        return attributedText
    }
}
