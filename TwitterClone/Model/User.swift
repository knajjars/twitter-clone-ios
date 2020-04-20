//
//  User.swift
//  TwitterClone
//
//  Created by Khalil Najjar on 4/19/20.
//  Copyright © 2020 Khalil Najjar. All rights reserved.
//

import Foundation

struct User {
    let userName: String
    let email: String
    let fullName: String
    var profileImageURL: URL?
    let uid: String
    
    init(uid: String, dictionary: [String: AnyObject]) {
        self.uid = uid
        
        self.userName = dictionary["userName"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.fullName = dictionary["fullName"] as? String ?? ""
        
        if let profileImageURLString = dictionary["profileImageURL"] as? String {
            guard let url = URL(string: profileImageURLString) else {return}
            self.profileImageURL = url
        }
    }
}
