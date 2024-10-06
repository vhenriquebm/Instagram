//
//  FeedViewController.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 26/03/24.
//

import UIKit
import Firebase


class FeedViewController: UICollectionViewController {
    var viewModel: FeedViewModelProtocol?
    private let refreshController = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        getPosts()
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        
        collectionView.register(FeedCollectionViewCell.self, forCellWithReuseIdentifier: FeedCollectionViewCell.identifier)
        
        
        configureNavigationBar()
        
        
        navigationItem.title = "Feed"
        
        refreshController.addTarget(self, action: #selector(refresh), for: .valueChanged)
        collectionView.refreshControl = refreshController
        
    }
    
    @objc func refresh() {
        self.viewModel?.postList.removeAll()
        self.collectionView.refreshControl?.endRefreshing()
        self.viewModel?.getPosts {
            self.collectionView.reloadData()
        }
    }
    
    private func configureNavigationBar() {
        
        if (viewModel?.post) != nil {
            let navigationButton = UIBarButtonItem(title: "Back",
                                                   style: .plain,
                                                   target: self,
                                                   action: #selector(back))
            navigationItem.leftBarButtonItem = navigationButton
            
        } else {
            let navigationButton = UIBarButtonItem(title: "Logout",
                                                   style: .plain,
                                                   target: self,
                                                   action: #selector(signOut))
            
            navigationItem.leftBarButtonItem = navigationButton
            
        }
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
    
    @objc private func back() {
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: - UICollectionViewDataSource

extension FeedViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.post == nil ? viewModel?.postList.count ?? 0 : 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedCollectionViewCell.identifier, for: indexPath) as! FeedCollectionViewCell
        
        if let post = viewModel?.post {
            cell.viewModel = FeedCollectionCellViewModel(post: post)
            return cell
        } else {
            guard let postList = viewModel?.postList[indexPath.row] else { return UICollectionViewCell() }
            
            cell.delegate = self
            cell.viewModel = FeedCollectionCellViewModel(post: postList)
        }
        
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension FeedViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.width + 160)
    }
}

//MARK: - FeedCellDelegate

extension FeedViewController: FeedCellDelegate {
    
    func cell(_ cell: FeedCollectionViewCell, wantsToShowProfileFor uid: String) {
        viewModel?.getUser(with: uid, completion: { user in
            
            let layout = UICollectionViewFlowLayout()
            let controller = ProfileViewController(collectionViewLayout: layout)
            controller.viewModel = ProfileViewModel(user: user)
            controller.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(controller, animated: false)
        })
    }
    
    func cell(_ cell: FeedCollectionViewCell, didLike post: PostList) {
        self.viewModel?.post?.didLike?.toggle()
        
        guard let tabBar = self.tabBarController as? MainTabBarController,
              let user = tabBar.user else { return }
        
        
        viewModel?.didTapLike(post: post, completion: { like in
            cell.setupLikeButton(like: like)
            
            if like {
                cell.viewModel?.post.likes = post.likes + 1
                
                self.viewModel?.uploadNotification(type: .like, post: post, user: user)
                
            } else {
                cell.viewModel?.post.likes = post.likes - 1
            }
        })
    }
    
    func cell(_ cell: FeedCollectionViewCell, wantsToShowCommentsFor post: PostList) {
                
        guard let tabBar = self.tabBarController as? MainTabBarController,
              let user = tabBar.user, 
              let navigation = self.navigationController else { return }
        
        let coordinator = CommentCoordinator(navigation: navigation,
                                             post: post, user: user)
        
        coordinator.start()
    }
}
