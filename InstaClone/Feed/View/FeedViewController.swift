//
//  FeedViewController.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 26/03/24.
//

import UIKit
import Firebase


class FeedViewController: UICollectionViewController {
    private var viewModel: FeedViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        viewModel = FeedViewModel(service: FeedService())
        getPosts()
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
    
    private func getPosts() {
        viewModel?.getPosts {
            self.collectionView.reloadData()
        }
    }
    
    private func goToLogin() {
        guard let navigation = self.navigationController else { return }
        let coordinator =  LoginCoordinator(navigation: navigation)
        coordinator.start()
    }
    
    @objc private func signOut() {
        viewModel?.signOut()
        goToLogin()
    }
}

//MARK: - UICollectionViewDataSource

extension FeedViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {        
        return viewModel?.posts.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedCollectionViewCell.identifier, for: indexPath) as! FeedCollectionViewCell
        
        if let post = viewModel?.posts[indexPath.row] {
            cell.viewModel = FeedCollectionCellViewModel(post: post)
        }
        
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension FeedViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 460)
    }
}
