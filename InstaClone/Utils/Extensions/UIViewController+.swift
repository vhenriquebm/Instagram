//
//  UIViewController+.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 20/09/24.
//

import UIKit
import JGProgressHUD

extension UIViewController {
    static let hud = JGProgressHUD(style: .dark)
    
    func showLoader(_ show: Bool) {
        view.endEditing(true)
        
        show ? UIViewController.hud.show(in: view) :             UIViewController.hud.dismiss()
    }
}
