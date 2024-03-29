//
//  UIButton+.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 26/03/24.
//

import UIKit

extension UIButton {
    func attributedTitle(firstText: String, secondText: String) {
        let attribute: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor(white: 1, alpha: 0.87), .font: UIFont.systemFont(ofSize: 16)]
        
        let attributedTitle = NSMutableAttributedString(string: firstText, attributes: attribute)
        
        let boldAttribute: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor(white: 1, alpha: 0.87), .font: UIFont.boldSystemFont(ofSize: 16)]
        
        attributedTitle.append(NSAttributedString(string: secondText, attributes: boldAttribute))
        
        setAttributedTitle(attributedTitle, for: .normal)
    }
}
