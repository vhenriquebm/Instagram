//
//  Coordinator.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 02/04/24.
//

import UIKit

protocol Coordinator {
    var navigation: UINavigationController { get set }
    
    func start()
}
