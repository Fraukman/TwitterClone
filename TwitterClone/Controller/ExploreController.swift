//
//  ExploreController.swift
//  TwitterClone
//
//  Created by Juan Souza on 12/04/20.
//  Copyright © 2020 Juan Souza. All rights reserved.
//

import UIKit

private let reuseIdentifier = "userCell"

class ExploreController: UITableViewController {
    
    
    //MARK: - Properties
    
    private var users = [User](){
        didSet {
            tableView.reloadData()
        }
    }
    
    private var filteredUsers = [User](){
        didSet{
            tableView.reloadData()
        }
    }
    
    private var inSearchMode: Bool {
        return searcController.isActive && !searcController.searchBar.text!.isEmpty
    }
    
    private let searcController = UISearchController(searchResultsController: nil)
    

    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        configureUI()
        fetchUsers()
        configureSearchController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           navigationController?.navigationBar.barStyle = .default
           navigationController?.navigationBar.isHidden = false

       }
    
    //MARK: - API
    
    func fetchUsers(){
        UserService.shared.fetchUser { (users) in
            self.users = users
        }
    }
    
    //MARK: - HelperFunctions
    
    func configureUI(){
        view.backgroundColor = .white
        
        navigationItem.title = "Explore"
        tableView.register(UserCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 60
        tableView.separatorStyle = .none
    }
    
    func configureSearchController(){
        searcController.searchResultsUpdater = self
        searcController.obscuresBackgroundDuringPresentation = false
        searcController.hidesNavigationBarDuringPresentation = false
        searcController.searchBar.placeholder = "Search for a user"
        navigationItem.searchController = searcController
        definesPresentationContext = false
    }
    
}

    //MARK: - UITableViewDataSource/Delegate

extension ExploreController{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inSearchMode ? filteredUsers.count : users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! UserCell
        let user = inSearchMode ? filteredUsers[indexPath.row] : users[indexPath.row]
        cell.user = user
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = inSearchMode ? filteredUsers[indexPath.row] : users[indexPath.row]

        let controller = ProfileController(user: user)
        navigationController?.pushViewController(controller, animated: true)
    }
    
}


    //MARK: - UISearchResultsUpdating

extension ExploreController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text?.lowercased() else {return}
        
        
        filteredUsers = users.filter({$0.username.contains(searchText)})
    }
    
    
}
