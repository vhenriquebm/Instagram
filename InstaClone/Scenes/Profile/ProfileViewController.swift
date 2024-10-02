//
//  ProfileViewController.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 26/03/24.
//

import UIKit

private let headerIndentifier = "ProfileHeader"
private let profileIdentifier = "ProfileCell"

class ProfileViewController: UICollectionViewController {
    var viewModel: ProfileViewModel?
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        getUser()
        checkIfUserIsFollowed()
        getUserStats()
        getPosts()
    }
    
    func configureView() {
        
        collectionView.backgroundColor = .white
        
        collectionView.register(ProfileCollectionViewCell.self, forCellWithReuseIdentifier: profileIdentifier)
        
        collectionView.register(ProfileHeader.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: headerIndentifier)
    }
    
    private func getUser() {
        self.user = viewModel?.getUser
        self.navigationItem.title = user?.username
    }
    
    private func getPosts() {
        guard let uuid = user?.uid else { return }
        viewModel?.getPosts(uuid: uuid, completion: {
            self.collectionView.reloadData()
        })
    }
    
    private func checkIfUserIsFollowed() {
        guard let uid = user?.uid else { return }
        
        viewModel?.checkIfUserIsFollowed(uid: uid, completion: { isFollowed in
            self.user?.isFollewed = isFollowed
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        })
    }
    
    private func getUserStats() {
        guard let uid = user?.uid else { return }

        viewModel?.getUserStats(uid: uid, completion: { stats in
            self.user?.userStats = stats
            self.collectionView.reloadData()
        })
    }
}

extension ProfileViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.posts.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: profileIdentifier, for: indexPath) as! ProfileCollectionViewCell
        
        if let post = viewModel?.posts[indexPath.row] {
            cell.viewModel = ProfileCollectionViewCellViewModel(post: post)
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = FeedViewController(collectionViewLayout: UICollectionViewFlowLayout())
        let feedViewModel = FeedViewModel(service: FeedService(), 
                                          userService: UserService(), 
                                          post: viewModel?.posts[indexPath.row])
        
        controller.viewModel = feedViewModel
        navigationController?.pushViewController(controller, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIndentifier, for: indexPath) as! ProfileHeader
        
        header.delegate = self
        
        if let user = user {
            header.viewModel = ProfileHeaderViewModel(user: user, posts: viewModel?.posts.count ?? 0)
        }
        
        return header
    }
}

extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (view.frame.width - 2 ) / 3
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 240)
    }
}

extension ProfileViewController: ProfileHeaderDelegate {
    func header(_ profileHeader: ProfileHeader, didTapActionButtonFor user: User) {
        if user.isCurrentUser {
            
        } else if user.isFollewed {
            viewModel?.unfollow(uuid: user.uid, completion: { error in
                self.user?.isFollewed = false
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            })
        } else {
            viewModel?.follow(uuid: user.uid, completion: { error in
                self.user?.isFollewed = true
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            })
        }
    }
}
