//
//  ProfileHeader.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 28/03/24.
//

import UIKit
import SDWebImage

protocol ProfileHeaderDelegate: AnyObject {
    func header(_ profileHeader: ProfileHeader, didTapActionButtonFor user: User)
}

class ProfileHeader: UICollectionReusableView {
    static let identifier = "ProfileHeader"
    
    weak var delegate: ProfileHeaderDelegate?
    
    var viewModel: ProfileHeaderViewModel? {
        didSet {configure()}
    }
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    
    private lazy var profileNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Venom"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var profileStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews:[ profileImageView, profileNameLabel])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var editProfileButton: UIButton = {
        let button = UIButton()
        button.setTitle("Edit Profile", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.backgroundColor = .white
        button.layer.cornerRadius = 3
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var postLabel: UILabel = {
        let label = UILabel()
        label.text = "posts"
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var followersLabel: UILabel = {
        let label = UILabel()
        label.text = "posts"
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var followingLabel: UILabel = {
        let label = UILabel()
        label.text = "posts"
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews:[ postLabel, followersLabel, followingLabel])
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var gridButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.grid, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor =  UIColor(white: 0, alpha: 0.2)
        return button
    }()
    
    private lazy var listButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.list, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor =  UIColor(white: 0, alpha: 0.2)
        return button
    }()
    
    private lazy var bookmarkButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.ribbon, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor =  UIColor(white: 0, alpha: 0.2)
        return button
    }()
    
    private lazy var topDivider: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var bottomDivider: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [gridButton, listButton, bookmarkButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        configureConstraints()
        configureBindings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        addSubview(profileStackView)
        addSubview(editProfileButton)
        addSubview(infoStackView)
        addSubview(buttonStackView)
        addSubview(topDivider)
        addSubview(bottomDivider)
        
        profileImageView.layer.cornerRadius =  80 / 2
        profileImageView.layer.masksToBounds = true
    }
    
    private func configureConstraints() {
        
        NSLayoutConstraint.activate([
            
            profileStackView.topAnchor.constraint(equalTo: topAnchor),
            profileStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            
            profileImageView.heightAnchor.constraint(equalToConstant: 80),
            profileImageView.widthAnchor.constraint(equalToConstant: 80),
            
            
            editProfileButton.topAnchor.constraint(equalTo: profileStackView.bottomAnchor, constant: 5),
            
            editProfileButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            editProfileButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            editProfileButton.heightAnchor.constraint(equalToConstant: 30),
            
            
            infoStackView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            infoStackView.leadingAnchor.constraint(equalTo: profileStackView.trailingAnchor, constant: 10),
            infoStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            topDivider.topAnchor.constraint(equalTo: editProfileButton.bottomAnchor, constant: 20),
            topDivider.leadingAnchor.constraint(equalTo: leadingAnchor),
            topDivider.trailingAnchor.constraint(equalTo: trailingAnchor),
            topDivider.heightAnchor.constraint(equalToConstant: 1),
            
            buttonStackView.topAnchor.constraint(equalTo: topDivider.bottomAnchor, constant: 5),
            buttonStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            buttonStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            gridButton.heightAnchor.constraint(equalToConstant: 50),
            listButton.heightAnchor.constraint(equalToConstant: 50),
            bookmarkButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func editProfile() {
        guard let viewModel = viewModel else { return }
        delegate?.header(self, didTapActionButtonFor: viewModel.getUser)
    }
    
    private func configureBindings() {
        editProfileButton.addTarget(self, action: #selector(editProfile), for: .touchUpInside)
    }
    
    private func configure() {
        guard let viewModel = viewModel else { return }
        
        profileNameLabel.text = viewModel.userName
        
        profileImageView.sd_setImage(with: viewModel.profileImageUrl)
        
        editProfileButton.setTitle(viewModel.followButtonText, for: .normal)
        
        editProfileButton.setTitleColor(viewModel.followButtonTextColor, for: .normal)
        
        editProfileButton.backgroundColor = viewModel.followButtonBackGroundColor
        
        postLabel.attributedText = viewModel.posts
        followersLabel.attributedText = viewModel.followers
        followingLabel.attributedText = viewModel.following
    }
}
