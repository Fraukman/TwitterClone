//
//  User.swift
//  TwitterClone
//
//  Created by Juan Souza on 15/04/20.
//  Copyright © 2020 Juan Souza. All rights reserved.
//

import Foundation
import Firebase

struct User {
    let fullname: String
    let email: String
    let username: String
    var profileImageUrl: URL?
    let uid: String
    
    var isCurrentUser: Bool {
        return Auth.auth().currentUser?.uid == uid
    }
    
    init(uid: String,dictionary: [String: AnyObject]) {
        self.uid = uid
        
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        
        if let profileImageUrl = dictionary["profileImageUrl"] as? String{
            guard let url = URL(string: profileImageUrl) else {return}
            self.profileImageUrl = url
        }


    }
}
