//
//  CustomTextField.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 26/03/24.
//

import UIKit

class CustomTextField: UITextField {
    
    init(placeholder: String, type: UIKeyboardType = .default, isSecureEntry: Bool = false) {
        super.init(frame: .zero)
        configureView(placeholder: placeholder, type: type, isSecureEntry: isSecureEntry)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView(placeholder: String, type: UIKeyboardType, isSecureEntry: Bool) {
        
        let spacer = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 50))
        leftView = spacer
        leftViewMode = .always
        
        borderStyle = .none
        textColor = .white
        keyboardAppearance = .dark
        keyboardType = type
        backgroundColor = UIColor(white: 1, alpha: 0.1)
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: UIColor(white: 1, alpha: 0.7)])
        isSecureTextEntry = isSecureEntry
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
