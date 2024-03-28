//
//  RegistrationView.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 27/03/24.
//

import UIKit

class RegistrationView: UIView {

    override func layoutSubviews() {
        super.layoutSubviews()
        configureGradientBackground()
        configureView()
    }
    
    private func configureView() {
        addSubview(addPhotoButton)
        addSubview(fieldsStackView)
        addSubview(alreadyHaveAnAccountButton)
        addSubview(loadingView)
        configureConstraints()
    }
    
    lazy var addPhotoButton: UIButton = {
        let button = UIButton()
        button.setImage(.plusPhoto.withRenderingMode(.alwaysTemplate), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = UIColor.white
        return button
    }()
    
     lazy var fieldsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, fullNameTextField, userNameTextField, registerButton])
        stackView.spacing = 10
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
     let emailTextField = CustomTextField(placeholder: "Email")
     let passwordTextField = CustomTextField(placeholder: "Password", isSecureEntry: true)
     let fullNameTextField = CustomTextField(placeholder: "Fullname")
     let userNameTextField = CustomTextField(placeholder: "Username")
    
     lazy var registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.backgroundColor = .systemPurple.withAlphaComponent(0.5)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.isEnabled = false
        return button
    }()
    
     lazy var alreadyHaveAnAccountButton: UIButton = {
        let button = UIButton()
        button.attributedTitle(firstText: "Already have an account?", secondText: "Log in")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var loadingView: UIActivityIndicatorView = {
       let view = UIActivityIndicatorView()
        view.hidesWhenStopped = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.style = .large
        view.color = UIColor.white
        return view
    }()
    
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            
            addPhotoButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            addPhotoButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            addPhotoButton.heightAnchor.constraint(equalToConstant: 150),
            addPhotoButton.widthAnchor.constraint(equalToConstant: 150),
            
            fieldsStackView.topAnchor.constraint(equalTo: addPhotoButton.bottomAnchor, constant: 20),
            
            fieldsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            fieldsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            registerButton.heightAnchor.constraint(equalToConstant: 50),
            
            alreadyHaveAnAccountButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 20),
            alreadyHaveAnAccountButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            alreadyHaveAnAccountButton.heightAnchor.constraint(equalToConstant: 50),
            
            loadingView.centerYAnchor.constraint(equalTo: centerYAnchor),
            loadingView.centerXAnchor.constraint(equalTo: centerXAnchor),
            loadingView.heightAnchor.constraint(equalToConstant: 50),
            loadingView.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
}
