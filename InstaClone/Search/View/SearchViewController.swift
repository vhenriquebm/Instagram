//
//  SearchViewController.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 26/03/24.
//

import UIKit

class SearchViewController: UITableViewController {
    var viewModel: SearchViewModelProtocol?
    private var users: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        getUsers()
    }
    
    private func configureView() {
        tableView.register(UserTableViewCell.self, forCellReuseIdentifier: UserTableViewCell.identifier)
    }
    
    private func getUsers() {
        viewModel?.getUsers(completion: { users in
            self.users = users
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }
    
    private func goToProfile(user: User) {
        guard let navigation = self.navigationController else { return }
        viewModel?.goToProfile(user: user, navigation: navigation)
    }
}

//MARK: - UITableViewDelegate

extension SearchViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let user = users[indexPath.row]
        
        goToProfile(user: user)
    }
}

//MARK: - UITableViewDataSource

extension SearchViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier, for: indexPath) as! UserTableViewCell
        
        let user = users[indexPath.row]
        
        cell.configure(user: user)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
