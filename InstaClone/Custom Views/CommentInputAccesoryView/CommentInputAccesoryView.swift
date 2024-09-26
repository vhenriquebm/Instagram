//
//  CommentInputAccesoryView.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 26/09/24.
//

import UIKit

class CommentInputAccesoryView: UIView {
    weak var delegate: CommentInputAccesoryViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        autoresizingMask = .flexibleHeight
        self.backgroundColor = .white
        addSubViews()
        configureConstraints()
        setupBindings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return .zero
    }
    
    private let commentTextView: InputTextView = {
        let textView = InputTextView()
        textView.placeholderText = "Enter comment.."
        textView.font = UIFont.systemFont(ofSize: 15)
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.placeholderShouldCenter = true
        return textView
    }()
    
    private let postButton: UIButton = {
        let button = UIButton()
        button.setTitle("Post", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        return button
    }()
    
    private let divider: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    @objc private func uploadComment() {
        self.delegate?.inputView(self, wantsToUpload: commentTextView.text)
    }
    
    private func addSubViews() {
        self.addSubview(commentTextView)
        self.addSubview(postButton)
        self.addSubview(divider)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            postButton.topAnchor.constraint(equalTo: self.topAnchor),
            postButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            postButton.heightAnchor.constraint(equalToConstant: 50),
            postButton.widthAnchor.constraint(equalToConstant: 50),
            
            commentTextView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            commentTextView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            commentTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 8),
            commentTextView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: 8),
            
            divider.topAnchor.constraint(equalTo: self.topAnchor),
            divider.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            divider.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            divider.heightAnchor.constraint(equalToConstant: 0.5)
        ])
    }
    
    private func setupBindings() {
        postButton.addTarget(self, action: #selector(uploadComment), for: .touchUpInside)
    }
    
    func clearCommentTextView() {
        commentTextView.text = nil
        commentTextView.placeholderLabel.isHidden = false
    }
}
