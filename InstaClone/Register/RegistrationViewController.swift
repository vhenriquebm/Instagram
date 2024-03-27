//
//  RegisterViewController.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 26/03/24.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    var delegate: RegistrationViewModelProtocol?
    
    private lazy var addPhotoButton: UIButton = {
        let button = UIButton()
        button.setImage(.plusPhoto.withRenderingMode(.alwaysTemplate), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = UIColor.white
        button.addTarget(self, action: #selector(selectPhoto), for: .touchUpInside)
        return button
    }()
    
    private lazy var fieldsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, fullNameTextField, userNameTextField, loginButton])
        stackView.spacing = 10
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let emailTextField = CustomTextField(placeholder: "Email")
    private let passwordTextField = CustomTextField(placeholder: "Password", isSecureEntry: true)
    private let fullNameTextField = CustomTextField(placeholder: "Fullname")
    private let userNameTextField = CustomTextField(placeholder: "Username")
    
    private lazy var loginButton: UIButton = {
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
    
    private lazy var alreadyHaveAnAccountButton: UIButton = {
        let button = UIButton()
        button.attributedTitle(firstText: "Already have an account?", secondText: "Log in")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(popViewController), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureObservers()
    }
    
    private func configureView() {
        view.configureGradientBackground()
        view.addSubview(addPhotoButton)
        view.addSubview(fieldsStackView)
        view.addSubview(alreadyHaveAnAccountButton)
        configureConstraints()
        self.delegate = RegistrationViewModel()
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            
            addPhotoButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            addPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addPhotoButton.heightAnchor.constraint(equalToConstant: 150),
            addPhotoButton.widthAnchor.constraint(equalToConstant: 150),
            
            fieldsStackView.topAnchor.constraint(equalTo: addPhotoButton.bottomAnchor, constant: 20),
            
            fieldsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            fieldsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            
            alreadyHaveAnAccountButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 20),
            alreadyHaveAnAccountButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            alreadyHaveAnAccountButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func popViewController() {
        self.navigationController?.popViewController(animated: false)
    }
    
    @objc private func textDidChange(sender: UITextField) {
        
        if sender == emailTextField {
            delegate?.email = sender.text
        } else if sender == passwordTextField {
            delegate?.password = sender.text
        } else if sender == fullNameTextField {
            delegate?.fullName = sender.text
        }  else if sender == userNameTextField {
            delegate?.userName = sender.text
        }
        
    
        if delegate?.isValid ?? false {
            loginButton.isEnabled = true
            loginButton.backgroundColor = UIColor.systemPurple
        }
    }
    
    @objc private func selectPhoto() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    
    private func configureObservers() {
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        fullNameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        userNameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
}


extension RegistrationViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.editedImage] as? UIImage else { return }
        picker.dismiss(animated: false)
        
        addPhotoButton.layer.cornerRadius = addPhotoButton.frame.width / 2
        addPhotoButton.layer.masksToBounds = true
        addPhotoButton.layer.borderWidth = 2
        addPhotoButton.layer.borderColor = UIColor.black.cgColor
        addPhotoButton.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
        
    }
}
