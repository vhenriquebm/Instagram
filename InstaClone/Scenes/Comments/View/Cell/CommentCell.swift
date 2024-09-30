//
//  CommentCollectionViewCell.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 26/09/24.
//

import UIKit

class CommentCell: UICollectionViewCell {
    static let identifier = "CommentCell"
    
    var viewModel: CommentCellViewModel? {
        didSet { configureUI() }
    }
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .lightGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var commentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        configureConstraints()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        self.contentView.addSubview(profileImageView)
        self.contentView.addSubview(commentLabel)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            profileImageView.heightAnchor.constraint(equalToConstant: 40),
            profileImageView.widthAnchor.constraint(equalToConstant: 40),
            
            commentLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            commentLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 10),
            commentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
        ])
    }
    
    private func configureUI() {
        profileImageView.layer.cornerRadius = 40 / 2
        
        self.profileImageView.sd_setImage(with: viewModel?.getImage)
        self.commentLabel.attributedText = viewModel?.commentLabelText()
    }
}
