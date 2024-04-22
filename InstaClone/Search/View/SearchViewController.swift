//
//  SearchViewController.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 26/03/24.
//

import UIKit

class SearchViewController: UITableViewController {
    var viewModel: SearchViewModelProtocol?
    private var users = [User]()
    private var filteredUsers = [User]()
    private var searchController = UISearchController()
    
    private var isSearchMode: Bool {
        return searchController.isActive && !searchController.searchBar.text!.isEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        getUsers()
        configureSearchController()
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
    
    private func configureSearchController() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
}

//MARK: - UITableViewDelegate

extension SearchViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let user = isSearchMode ? filteredUsers[indexPath.row] : users[indexPath.row]
        
        goToProfile(user: user)
    }
}

//MARK: - UITableViewDataSource

extension SearchViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearchMode ? filteredUsers.count : users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier, for: indexPath) as! UserTableViewCell
        
        let user = isSearchMode ? filteredUsers[indexPath.row] : users[indexPath.row]
        
        cell.configure(user: user)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension SearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        print ("Aciounou o update")
        
        guard let searchText = searchController.searchBar.text?.lowercased() else { return }
        
        print ("The search Text is \(searchText)")
        
        filteredUsers = users.filter {
            $0.username.contains(searchText) ||
            $0.fullname.lowercased().contains(searchText)}
        
        tableView.reloadData()
    }
    
}
