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

    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        configureUI()
        fetchUsers()
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
}

    //MARK: - UITableViewDataSource/Delegate

extension ExploreController{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! UserCell
        cell.user = users[indexPath.row]
        return cell
    }
    
}
