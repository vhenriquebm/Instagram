//
//  ProfileCollectionViewCell.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 28/03/24.
//

import UIKit

class ProfileCollectionViewCell: UICollectionViewCell {
    static let identifier = "ProfileCollectionViewCell"
    
    var viewModel: ProfileCollectionViewCellViewModel? {
        didSet { configureUI() }
    }
    
    private lazy var postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .venom7
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        
        addSubview(postImageView)
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureConstraints() {
        
        NSLayoutConstraint.activate([
            postImageView.topAnchor.constraint(equalTo: self.topAnchor),
            postImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            postImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    private func configureUI() {
        self.postImageView.sd_setImage(with: viewModel?.getImage)        
    }
}
