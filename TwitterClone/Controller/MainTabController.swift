//
//  MainTabController.swift
//  TwitterClone
//
//  Created by Juan Souza on 12/04/20.
//  Copyright © 2020 Juan Souza. All rights reserved.
//

import UIKit
import Firebase

class MainTabController: UITabBarController {
    
    //MARK: - Properties
    
    var user: User? {
        didSet{
            guard let nav = viewControllers?[0] as? UINavigationController else {return}
            guard let feed = nav.viewControllers.first as? FeedController else {return}
            
            feed.user = user
        }
    }
    
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
        
        view.backgroundColor = .mainBlue
        authenticateUserAndConfigureUI()
        
    }
    
    //MARK: - Selectors
    
    @objc func actionButtonTapped(){
        guard let user = user else {return}
        let controller = UploadTweetController(user: user)
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
    }
    
    //MARK: - API
    
    func fetchUser(){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        UserService.shared.fetchUser(uid: uid) { (user) in
            self.user = user
        }
    }
    
    func authenticateUserAndConfigureUI(){
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginController())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        }else {
            configureControllers()
            configureUI()
            fetchUser()
        }
    }
    
    func signOut(){
        do {
            try Auth.auth().signOut()
        }catch let error {
            print("DEBUG: Failed to sign out with error: \(error.localizedDescription)")
        }
    }
    
    //MARK: - HelperFunctions
    
    func configureUI(){
        view.addSubview(actionButton)
        actionButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingBottom: 64, paddingRight: 16, width: 56, height: 56)
        actionButton.layer.cornerRadius = 56 / 2
    }
    
    func configureControllers(){
        
        let feedControllerLayout = FeedController(collectionViewLayout: UICollectionViewFlowLayout())
        let feed = templateNavigarionController(image: UIImage(named: "home_unselected"), rootViewController: feedControllerLayout)
        
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
