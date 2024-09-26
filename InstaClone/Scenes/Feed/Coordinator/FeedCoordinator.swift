//
//  FeedCoordinator.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 02/04/24.
//

import UIKit

class FeedCoordinator: Coordinator {
    var navigation: UINavigationController
    
    init(navigation: UINavigationController) {
        self.navigation = navigation
    }
    
    func start() {
        let controller = FeedViewController()
    }
}
