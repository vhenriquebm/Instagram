//
//  FeedCollectionViewCell.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 26/03/24.
//

import UIKit

class FeedCollectionViewCell: UICollectionViewCell {
    static let identifier = "FeedCollectionViewCell"
    
    var viewModel: FeedCollectionCellViewModel? {
        didSet { configure() }
    }
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    
    private lazy var userNameButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        return button
    }()
    
    private lazy var postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var bottomStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [likeButton, commentButton, shareButton])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.likeUnselected, for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        return button
    }()
    
    private lazy var commentButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.comment, for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        return button
    }()
    
    private lazy var shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.send2, for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        return button
    }()
    
    private lazy var likesLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var captionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var ribbonButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.ribbon, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .black
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        self.contentView.addSubview(profileImageView)
        self.contentView.addSubview(userNameButton)
        self.contentView.addSubview(postImageView)
        self.contentView.addSubview(likeButton)
        self.contentView.addSubview(bottomStackView)
        self.bottomStackView.addSubview(commentButton)
        self.bottomStackView.addSubview(shareButton)
        self.bottomStackView.addSubview(likesLabel)
        self.contentView.addSubview(ribbonButton)
        self.contentView.addSubview(captionLabel)
        
        profileImageView.layer.cornerRadius = 40 / 2
        profileImageView.layer.masksToBounds = true
        
        configureConstraints()
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            
            profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            profileImageView.heightAnchor.constraint(equalToConstant: 40),
            profileImageView.widthAnchor.constraint(equalToConstant: 40),
            
            userNameButton.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 5),
            userNameButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            userNameButton.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor),
            
            postImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postImageView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 10),
            postImageView.heightAnchor.constraint(equalToConstant: contentView.frame.width),
            
            bottomStackView.topAnchor.constraint(equalTo: postImageView.bottomAnchor,constant: 10),
            
            bottomStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            
            ribbonButton.topAnchor.constraint(equalTo: postImageView.bottomAnchor,constant: 5),
            ribbonButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            
            likesLabel.topAnchor.constraint(equalTo: bottomStackView.bottomAnchor, constant: 10),
            likesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            likesLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 10),
            
            captionLabel.topAnchor.constraint(equalTo: likesLabel.bottomAnchor, constant: 5),
            captionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            captionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 10)

        ])
    }
    
    private func configure() {
        guard let viewModel = viewModel else { return }
        
        profileImageView.sd_setImage(with: viewModel.ownerImageUrl)
        userNameButton.setTitle(viewModel.ownerUserName, for: .normal)

        postImageView.sd_setImage(with: viewModel.imageUrl)
        self.captionLabel.text = viewModel.caption
        self.likesLabel.text = viewModel.likes
    }
}
