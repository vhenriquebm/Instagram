//
//  UploadPostViewController.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 11/09/24.
//

import UIKit

class UploadPostViewController: UIViewController {
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = .venom7
        return imageView
    }()
    
    private lazy var captionTextView: InputTextView = {
        let textView = InputTextView()
        textView.placeholderText = "Enter caption.."
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.delegate = self
        return textView
    }()
    
    private let characterCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "0/100"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    private func configureView() {
        self.view.backgroundColor = .white
        configureNavigation()
        addSubViews()
        configureConstraints()
        configurePhotoImageView()
    }
    
    private func configureNavigation() {
        navigationItem.title = "Upload Posts"
        
        navigationItem.leftBarButtonItem = createLeftBarButton()
        navigationItem.rightBarButtonItem = createRightBarButton()
    }
    
    
    private func createLeftBarButton() -> UIBarButtonItem {
        return UIBarButtonItem(barButtonSystemItem: .cancel,
                               target: self,
                               action: #selector(didTapCancel))
    }
    
    private func createRightBarButton() -> UIBarButtonItem {
        return UIBarButtonItem(title: "Share",
                               style: .plain,
                               target: self,
                               action: #selector(didTapShare))
    }
    
    private func addSubViews() {
        view.addSubview(photoImageView)
        view.addSubview(captionTextView)
        view.addSubview(characterCountLabel)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            
            photoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            photoImageView.heightAnchor.constraint(equalToConstant: 180),
            photoImageView.widthAnchor.constraint(equalToConstant: 180),
            photoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            captionTextView.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 5),
            captionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            captionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 5),
            captionTextView.heightAnchor.constraint(equalToConstant: 64),
            
            characterCountLabel.topAnchor.constraint(equalTo: captionTextView.bottomAnchor, constant: 5),
            characterCountLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
    }
    
    private func configurePhotoImageView() {
        photoImageView.layer.cornerRadius = 10
    }
    
    @objc private func didTapCancel() {
        dismiss(animated: true)
    }
    
    @objc private func didTapShare() {
        
    }
    
    private func checkMaxLength(_ textView: UITextView) {
        if (textView.text.count) > 100 {
            textView.deleteBackward()
        }
    }
}

//MARK: - UITextViewDelegate

extension UploadPostViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        checkMaxLength(textView)
        let count = textView.text.count
        characterCountLabel.text = "\(count)/100"
    }
}
