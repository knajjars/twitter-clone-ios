//
//  UserService.swift
//  TwitterClone
//
//  Created by Khalil Najjar on 4/19/20.
//  Copyright © 2020 Khalil Najjar. All rights reserved.
//

import Firebase

class UserService {
    static let shared = UserService()
    
    func fetchUser(completion: @escaping (User) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        USER_REF.child(uid).observeSingleEvent(of: .value) { (snapshot) in
            guard let dictionary = snapshot.value as? [String: AnyObject] else {return}
            
            let user = User(uid: uid, dictionary: dictionary)
            completion(user)
        }
    }
}
