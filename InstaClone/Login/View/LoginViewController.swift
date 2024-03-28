//
//  LoginViewController.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 26/03/24.
//

import UIKit

class LoginViewController: UIViewController {
    
    var delegate: LoginViewModelProtocol?
    
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .instagramLogoWhite
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var credentialsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton, forgetPasswordButton])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var emailTextField: CustomTextField = {
        let textField = CustomTextField(placeholder: "Email", type: .emailAddress)
        return textField
    }()
    
    private lazy var passwordTextField: CustomTextField = {
        let textField = CustomTextField(placeholder: "Password", isSecureEntry: true)
        return textField
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log in", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.backgroundColor = UIColor.systemPurple.withAlphaComponent(0.5)
        button.isEnabled = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        return button
    }()
    
    lazy var loadingView: UIActivityIndicatorView = {
       let view = UIActivityIndicatorView()
        view.hidesWhenStopped = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.style = .medium
        view.color = UIColor.white
        return view
    }()
    
    private lazy var forgetPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.white, for: .normal)
        
        button.attributedTitle(firstText: "Forgout your password?",
                               secondText: " Get help signing in.")
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    private lazy var dontHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.attributedTitle(firstText: "Don't have an account?",
                               secondText: "Sign up")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(goToRegister), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        self.delegate = LoginViewModel()
        configureObservers()
    }
    
    private func configureView() {
        view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        
        view.configureGradientBackground()
        
        view.addSubview(logoImageView)
        view.addSubview(credentialsStackView)
        view.addSubview(dontHaveAccountButton)
        view.addSubview(loadingView)
        
        configureConstraints()
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            
            logoImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            
            logoImageView.heightAnchor.constraint(equalToConstant: 80),
            logoImageView.widthAnchor.constraint(equalToConstant: 120),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            credentialsStackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 40),
            credentialsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            credentialsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            
            dontHaveAccountButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            dontHaveAccountButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dontHaveAccountButton.heightAnchor.constraint(equalToConstant: 50),
            
            forgetPasswordButton.heightAnchor.constraint(equalToConstant: 50),
            
            loadingView.heightAnchor.constraint(equalToConstant: 50),
            loadingView.widthAnchor.constraint(equalToConstant: 50),
            loadingView.centerXAnchor.constraint(equalTo: loginButton.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: loginButton.centerYAnchor),
        ])
    }
    
    @objc private func goToRegister() {
        let controller = RegistrationViewController()
        self.navigationController?.pushViewController(controller, animated: false)
    }
    
    @objc private func textDidChange(sender: UITextField) {
        
        if sender == emailTextField {
            delegate?.email = sender.text
        } else if sender == passwordTextField {
            delegate?.password = sender.text
        }
        
        if delegate?.isValid ?? false {
            loginButton.isEnabled = true
            loginButton.backgroundColor = UIColor.systemPurple
        }
    }
    
    
    private func configureGradientBackground(view: UIView) {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.systemPurple.cgColor, UIColor.systemBlue.cgColor]
        gradient.locations = [0,1]
        view.layer.addSublayer(gradient)
        gradient.frame = view.frame
    }
    
    private func configureObservers() {
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        loginButton.addTarget(self, action:  #selector(login), for: .touchUpInside)
        
    }
    
    @objc private func login() {
        guard let email = emailTextField.text,
              let password = passwordTextField.text else { return }
        
        loginButton.setTitle("", for: .normal)
        loadingView.startAnimating()
        
        delegate?.login(with: email, and: password, completion: { result, error in
            
            self.loginButton.setTitle("Log in", for: .normal)
            self.loadingView.stopAnimating()
            
            guard error == nil  else { return }
            
            self.goToFeedViewController()
            
        })
    }
    
    private func goToFeedViewController() {
        let controller = MainTabBarController()
        let navigation = UINavigationController(rootViewController: controller)
        navigation.modalPresentationStyle = .fullScreen
        
        self.dismiss(animated: true) {
                self.present(navigation, animated: true)
            }
    }
    
    deinit {
        print ("The login controller is not in the memory anymore")
    }
}

