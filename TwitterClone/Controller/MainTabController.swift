//
//  MainTabController.swift
//  TwitterClone
//
//  Created by Juan Souza on 12/04/20.
//  Copyright © 2020 Juan Souza. All rights reserved.
//

import UIKit

class MainTabController: UITabBarController {
    
    //MARK: - Properties
    
    let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.backgroundColor = .mainBlue
        button.setImage(UIImage(named: "new_tweet"), for: .normal)
        
        button.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureControllers()
        configureUI()
    }
    
    //MARK: - Selectors
    
    @objc func actionButtonTapped(){
        print("DEBUG: Handle new tweet")
    }
    
    //MARK: - HelperFunctions
    
    func configureUI(){
        view.addSubview(actionButton)
        actionButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingBottom: 64, paddingRight: 16, width: 56, height: 56)
        actionButton.layer.cornerRadius = 56 / 2
    }
    
    func configureControllers(){
        
        let feed = templateNavigarionController(image: UIImage(named: "home_unselected"), rootViewController: FeedController())
        
        let explore = templateNavigarionController(image: UIImage(named: "search_unselected"), rootViewController: ExploreController())
        
        let notifications = templateNavigarionController(image: UIImage(named: "like_unselected"), rootViewController: NotificationsController())
        
        let conversations = templateNavigarionController(image: UIImage(named: "ic_mail_outline_white_2x-1"), rootViewController: ConversationsController())
       
        viewControllers = [feed,explore,notifications,conversations]
    }
    
    func templateNavigarionController(image: UIImage?, rootViewController: UIViewController) -> UINavigationController{
        
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = image
        nav.navigationBar.barTintColor = .white
        return nav
        
    }
}