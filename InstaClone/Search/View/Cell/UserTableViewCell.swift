//
//  UserTableViewCell.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 10/04/24.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    static let identifier = "UserTableViewCell"
    
    private let searchView: SearchView = {
        let searchView = SearchView()
        searchView.translatesAutoresizingMaskIntoConstraints = false
        return searchView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(searchView)
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: contentView.topAnchor),
            searchView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            searchView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            searchView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configure(user: User) {
        searchView.userNambeLabel.text = user.username
        searchView.fullNameLabel.text = user.fullname
        
        let urlImage = URL(string: user.profileImageUrl)
        searchView.profileImageView.sd_setImage(with: urlImage)
    }
}
