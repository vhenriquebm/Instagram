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
    
    
//    private func getUser() {
//        viewModel?.getUser(completion: { user in
//            DispatchQueue.main.async {
//                self.user = user
//                self.navigationItem.title = user.username
//                self.collectionView.reloadData()
//            }
//        })
//    }
}

extension ProfileViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    
    
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: profileIdentifier, for: indexPath) as! ProfileCollectionViewCell
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIndentifier, for: indexPath) as! ProfileHeader
        
        if let user = user {
            print ("Tem usuário")
            
            header.viewModel = ProfileHeaderViewModel(user: user)
        } else {
            print ("Não tem usuário")
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
