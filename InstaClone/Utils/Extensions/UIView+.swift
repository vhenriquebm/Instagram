//
//  UIView+.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 27/03/24.
//

import UIKit

extension UIView {
    func configureGradientBackground() {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.systemPurple.cgColor, UIColor.systemBlue.cgColor]
        gradient.locations = [0,1]
        layer.addSublayer(gradient)
        gradient.frame = frame
    }
}
