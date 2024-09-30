//
//  CommentViewController.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 26/09/24.
//

import UIKit

class CommentViewController: UICollectionViewController {
    var viewModel: CommentViewModelProtocol?
    
    private lazy var commentInputView: CommentInputAccesoryView = {
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        let view = CommentInputAccesoryView(frame: frame)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        getComments()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override var inputAccessoryView: UIView? {
        get { return commentInputView }
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    func configureView() {
        navigationItem.title = "Comments"
        
        collectionView.backgroundColor = .white
        
        collectionView.register(CommentCell.self, forCellWithReuseIdentifier: CommentCell.identifier)
        
        collectionView.alwaysBounceVertical = true
        collectionView.keyboardDismissMode = .interactive
    }
    
    private func getComments() {
        self.viewModel?.getComments {
            self.collectionView.reloadData()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.comments.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CommentCell.identifier, for: indexPath) as! CommentCell
        
        if let comment = self.viewModel?.comments[indexPath.row] {
            cell.viewModel = CommentCellViewModel(comment: comment)
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let uid = viewModel?.comments[indexPath.row].uid,
              let navigation = self.navigationController else { return }
        
        viewModel?.getUser(with: uid)
    }
}

extension CommentViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }
}

//MARK: - CommentInputAccesoryViewDelegate

extension CommentViewController: CommentInputAccesoryViewDelegate {
    func inputView(_ inputView: CommentInputAccesoryView, wantsToUpload comment: String) {
        self.showLoader(true)
        inputView.clearCommentTextView()
        self.viewModel?.uploadComment(comment: comment, completion: {
            self.showLoader(false)
        })
    }
}
