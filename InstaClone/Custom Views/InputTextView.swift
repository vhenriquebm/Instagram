//
//  InputTextView.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 11/09/24.
//

import UIKit

class InputTextView: UITextView {
    
    let placeholderLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var placeholderText: String? {
        didSet { placeholderLabel.text = placeholderText }
    }
    
    var placeholderShouldCenter = true {
        didSet {
            if placeholderShouldCenter {
                configurePlaceHolderConstraints(placeholderShouldCenter: true)
            } else {
                configurePlaceHolderConstraints(placeholderShouldCenter: false)
            }
        }
    }
    
    func configurePlaceHolderConstraints(placeholderShouldCenter: Bool) {
        
        if placeholderShouldCenter {
            NSLayoutConstraint.activate([
                placeholderLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
                placeholderLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 8),
                placeholderLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ])
        } else {
            NSLayoutConstraint.activate([
                placeholderLabel.topAnchor.constraint(equalTo: topAnchor, constant: 6),
                placeholderLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8)
            ])
        }
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        addSubview(placeholderLabel)
        configureConstraints()
        addObserver()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            placeholderLabel.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            placeholderLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8)
        ])
    }
    
    private func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextDidChange), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    @objc private func handleTextDidChange() {
        placeholderLabel.isHidden = !text.isEmpty
    }
}
