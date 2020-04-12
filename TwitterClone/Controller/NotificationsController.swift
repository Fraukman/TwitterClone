//
//  NotificationController.swift
//  TwitterClone
//
//  Created by Juan Souza on 12/04/20.
//  Copyright © 2020 Juan Souza. All rights reserved.
//

import UIKit

class NotificationsController: UIViewController {
    
     
    //MARK: - Properties

    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()

    }
    
    //MARK: - HelperFunctions
    func configureUI(){
        view.backgroundColor = .white
        
        navigationItem.title = "Notifications"
    }
}

