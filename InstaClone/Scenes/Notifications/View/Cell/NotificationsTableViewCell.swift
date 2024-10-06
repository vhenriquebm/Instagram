//
//  NotificationsTableViewCell.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 01/10/24.
//

import UIKit

class NotificationsTableViewCell: UITableViewCell {
    static let identifier = "NotificationsTableViewCell"
    
    var viewModel: NotificationsTableViewCellViewModel? {
        didSet { configure() }
    }
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .lightGray
        imageView.image = .venom7
        return imageView
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let followButton: UIButton = {
        let button = UIButton()
        button.setTitle("Loading", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.backgroundColor = .white
        button.layer.cornerRadius = 3
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        contentView.addSubview(profileImageView)
        contentView.addSubview(infoLabel)
        contentView.addSubview(postImageView)
        
        profileImageView.layer.cornerRadius =  48 / 2
        profileImageView.layer.masksToBounds = true
        addGestures()
    }
    
    private func configureConstraints() {
        
        NSLayoutConstraint.activate([
            
            profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            profileImageView.heightAnchor.constraint(equalToConstant: 48),
            profileImageView.widthAnchor.constraint(equalToConstant: 48),
            
            infoLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            infoLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 10),
            
            postImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            postImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            postImageView.heightAnchor.constraint(equalToConstant: 48),
            postImageView.widthAnchor.constraint(equalToConstant: 48),
        ])
    }
    
    private func configure() {
        self.profileImageView.sd_setImage(with: viewModel?.profileImageUrl)
        self.infoLabel.attributedText = viewModel?.message
        self.postImageView.sd_setImage(with: viewModel?.postImageView)
    }
    
    private func addGestures() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(onTapPostImageView))
        postImageView.addGestureRecognizer(gesture)
    }
    
    @objc private func onTapPostImageView() {
        
    }
    
    @objc private func onTapFollowButton() {
        
    }
}
