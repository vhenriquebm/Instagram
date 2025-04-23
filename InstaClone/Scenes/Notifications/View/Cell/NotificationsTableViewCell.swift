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
    
    weak var delegate: NotificationCellDelegate?
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .lightGray
        imageView.image = .venom7
        imageView.isUserInteractionEnabled = true
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
    
    private lazy var postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private lazy var followButton: UIButton = {
        let button = UIButton()
        button.setTitle("Loading", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.backgroundColor = .white
        button.layer.cornerRadius = 3
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.isUserInteractionEnabled = true
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
        addSubViews()
        
        self.selectionStyle = .none
        
        profileImageView.layer.cornerRadius =  48 / 2
        profileImageView.layer.masksToBounds = true
        addGestures()
    }
    
    private func addSubViews() {
        contentView.addSubview(profileImageView)
        contentView.addSubview(infoLabel)
        contentView.addSubview(postImageView)
        contentView.addSubview(followButton)
    }
    
    private func configureConstraints() {
        
        NSLayoutConstraint.activate([
            
            profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            profileImageView.heightAnchor.constraint(equalToConstant: 48),
            profileImageView.widthAnchor.constraint(equalToConstant: 48),
            
            infoLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            infoLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 10),
            infoLabel.trailingAnchor.constraint(equalTo: followButton.leadingAnchor, constant: 4),
            
            postImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            postImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            postImageView.heightAnchor.constraint(equalToConstant: 48),
            postImageView.widthAnchor.constraint(equalToConstant: 48),
            
            followButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            followButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            followButton.heightAnchor.constraint(equalToConstant: 32),
            followButton.widthAnchor.constraint(equalToConstant: 100),
            
        ])
    }
    
    private func configure() {
        self.profileImageView.sd_setImage(with: viewModel?.profileImageUrl)
        self.infoLabel.attributedText = viewModel?.message
        self.postImageView.sd_setImage(with: viewModel?.postImageView)
        self.followButton.setTitle(viewModel?.followButtonText, for: .normal)
        self.followButton.backgroundColor = viewModel?.followButtonBackgroundColor
        self.followButton.setTitleColor(viewModel?.followButtonTextColor, for: .normal)
        
        if let viewModel = viewModel {
            followButton.isHidden = !viewModel.shouldHidePostImage
            postImageView.isHidden = viewModel.shouldHidePostImage
        }
    }
    
    func setupFollowButtonState() {
        self.followButton.setTitle(viewModel?.followButtonText, for: .normal)
        self.followButton.backgroundColor = viewModel?.followButtonBackgroundColor
        self.followButton.setTitleColor(viewModel?.followButtonTextColor, for: .normal)
    }
    
    private func addGestures() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(onTapPostImageView))
        postImageView.addGestureRecognizer(gesture)
        
        followButton.addTarget(self, action: #selector(onTapFollowButton), for: .touchUpInside)

    }
    
    @objc func handlePostTapped() {
        guard let postId = viewModel?.notification.postId else { return }
        delegate?.cell(self, wantsToViewPost: postId)
    }
    
    @objc private func onTapPostImageView() {
        guard let postId = viewModel?.notification.postId else { return }
        delegate?.cell(self, wantsToViewPost: postId)
    }
    
    @objc private func onTapFollowButton() {
        guard let viewModel = viewModel else { return }
        
        if viewModel.notification.userIsFollowed {
            delegate?.cell(self, wantsToUnFollow: viewModel.notification.uid)
        } else {
            delegate?.cell(self, wantsToFollow: viewModel.notification.uid)
        }        
    }
}
