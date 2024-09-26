//
//  SearchView.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 10/04/24.
//

import UIKit

class SearchView: UIView {
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .lightGray
        imageView.backgroundColor = .lightGray
        imageView.image = UIImage(named: "venom-7")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let userNambeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "venom"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let fullNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "Eddie Brock"
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var userStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [userNambeLabel, fullNameLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.alignment = .leading
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(profileImageView)
        addSubview(userStackView)
        configureConstraints()
        
        profileImageView.layer.cornerRadius = 40 / 2
        profileImageView.layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            
            profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            profileImageView.heightAnchor.constraint(equalToConstant: 40),
            profileImageView.widthAnchor.constraint(equalToConstant: 40),
            
            userStackView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            userStackView.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 10)
        ])
    }
}
