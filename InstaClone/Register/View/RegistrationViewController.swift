//
//  RegisterViewController.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 26/03/24.
//

import UIKit

class RegistrationViewController: UIViewController {
    private var registrationView: RegistrationView?
    private var delegate: RegistrationViewModelProtocol?
    private var profileImage: UIImage?
    
    override func loadView() {
        registrationView = RegistrationView()
        view = registrationView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureButton()
        configureObservers()
    }
    
    private func configureView() {
        self.delegate = RegistrationViewModel()
    }
    
    private func configureButton() {
        registrationView?.addPhotoButton.addTarget(self, action: #selector(selectPhoto), for: .touchUpInside)
        registrationView?.alreadyHaveAnAccountButton.addTarget(self, action: #selector(popViewController), for: .touchUpInside)
        
        registrationView?.registerButton.addTarget(self, action: #selector(register), for: .touchUpInside)
        
    }
    
    @objc private func textDidChange(sender: UITextField) {
        if sender == registrationView?.emailTextField {
            delegate?.email = sender.text
        } else if sender == registrationView?.passwordTextField {
            delegate?.password = sender.text
        } else if sender == registrationView?.fullNameTextField {
            delegate?.fullName = sender.text
        }  else if sender == registrationView?.userNameTextField {
            delegate?.userName = sender.text
        }
        
        if delegate?.isValid ?? false {
            registrationView?.registerButton.isEnabled = true
            registrationView?.registerButton.backgroundColor = UIColor.systemPurple
        }
    }
    
    @objc private func popViewController() {
        self.navigationController?.popViewController(animated: false)
    }
    
    @objc private func register() {
        registrationView?.loadingView.startAnimating()
        
        guard let email = registrationView?.emailTextField.text,
              let password = registrationView?.passwordTextField.text,
              let fullName = registrationView?.fullNameTextField.text,
              let userName = registrationView?.userNameTextField.text else { return }
        
        
        let userRegistration = UserRegistration(email: email,
                                                password: password,
                                                fullName: fullName,
                                                userName: userName,
                                                profileImage: profileImage)
        
        delegate?.register(with: userRegistration, completion: { result in
            
            DispatchQueue.main.async {
                self.registrationView?.loadingView.stopAnimating()
                self.dismiss(animated: true)
            }
            
        })
    }
    
    @objc private func selectPhoto() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    
    private func configureObservers() {
        registrationView?.emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        registrationView?.passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        registrationView?.fullNameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        registrationView?.userNameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
}


extension RegistrationViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.editedImage] as? UIImage else { return }
        profileImage = image
        picker.dismiss(animated: false)
        
        let button = registrationView?.addPhotoButton
        
        button?.layer.cornerRadius = (button?.frame.width ?? 0) / 2
        button?.layer.masksToBounds = true
        button?.layer.borderWidth = 2
        button?.layer.borderColor = UIColor.black.cgColor
        button?.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
    }
}
