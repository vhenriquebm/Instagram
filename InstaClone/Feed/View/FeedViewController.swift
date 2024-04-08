//
//  FeedViewController.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 26/03/24.
//

import UIKit
import Firebase


class FeedViewController: UICollectionViewController {
    private var delegate: FeedViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        delegate = FeedViewModel()
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        
        collectionView.register(FeedCollectionViewCell.self, forCellWithReuseIdentifier: FeedCollectionViewCell.identifier)
        
        
      configureNavigationBar()
        
        
        navigationItem.title = "Feed"
        
    }
    
    private func configureNavigationBar() {
        
        let navigationButton = UIBarButtonItem(title: "Logout",
                                               style: .plain,
                                               target: self, 
                                               action: #selector(signOut))
        
        navigationItem.leftBarButtonItem = navigationButton
    }
    
    
    private func goToLogin() {
        guard let navigation = self.navigationController else { return }
        let coordinator =  LoginCoordinator(navigation: navigation)
        coordinator.start()
    }
    
    @objc private func signOut() {
        delegate?.signOut()
        goToLogin()
    }
}

//MARK: - UICollectionViewDataSource

extension FeedViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedCollectionViewCell.identifier, for: indexPath) as! FeedCollectionViewCell
        
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension FeedViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 420)
    }
}
